###########################
### The 'refill.txt' source file contains data downloaded from
### the TFCat database. These are annotated with mouse (Mus musculus)
### Entrez Gene IDs. We want to (1) pick out only genes with
### 'Strong' evidence and (2) find their corresponding human (Homo sapiens)
### names and Entrez Gene IDs.

source("00-paths.R")

tf <- read.table(file.path(paths$raw, "refill.txt"),
                 sep="\t", header=TRUE, fill=TRUE, quote="")

g <- grep("GeneID", tf$PubMed.Comments)
g
tf <- tf[-g,]

w <- which(tf$Judgement == "")
tf <- tf[-w,]

dim(tf)
summary(tf)

tfs <- tf[grep("Strong", tf$Evidence.Strength),]
length(unique(tfs$Gene.ID))

if (FALSE) {
  hu <- grep("Human", tf$Species)

  tfh <- tf[hu,]
  dim(tfh)
  summary(tfh)

  str <- grep("Strong", tfh$Evidence.Strength)
  tfhs <- tfh[str,]
  dim(tfhs)
  summary(tfhs)
} else {
  tfhs <- tfs
}

dup <- duplicated(tfhs$Gene.ID)
summary(dup)

utfhs <- tfhs[!dup,]
dim(utfhs)
summary(utfhs)

library(Mus.musculus)

res <- select(Mus.musculus, keys=as.character(utfhs$Gene.ID), keytype="ENTREZID",
              columns=c("SYMBOL"))
dim(res)

sym <- toupper(res$SYMBOL)

library(Homo.sapiens)
hres <- select(Homo.sapiens, keys=sym, keytype="SYMBOL",
              columns=c("ENTREZID", "MAP", "TXCHROM"))
dim(hres)

dsym <- hres$SYMBOL[dup <- duplicated(hres$SYMBOL)]
garble <- which(hres$SYMBOL %in% dsym)
hres[garble,]

uhres <- hres[!dup,]
all(sym == uhres$SYMBOL)
all(res$ENTREZID==utfhs$Gene.ID)

temp <- cbind(utfhs, res, Hs=uhres)
colnames(temp)

keep <- c(1, 10, 14:18, 8:9, 2:4, 6)
short <- temp[,keep]
short$Hs.TXCHROM <- factor(short$Hs.TXCHROM,
                           levels=paste("chr", c(1:22, "X", "Y"), sep=''))
colnames(short)
summary(short)
short <- short[order(short$Hs.TXCHROM),]

write.csv(short, file.path(paths$clean, "HumanTF.csv"), row.names=FALSE)
