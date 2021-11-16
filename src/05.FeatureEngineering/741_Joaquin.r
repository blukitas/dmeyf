#Necesita para correr en Google Cloud
#32 GB de memoria RAM
#256 GB de espacio en el disco local
#8 vCPU

#limpio la memoria
rm( list=ls() )  #remove all objects
gc()             #garbage collection

require("data.table")
require("ggplot2")


#Aqui comienza el programa
setwd("~/buckets/b1")

#cargo el dataset donde voy a entrenar
dataset  <- fread("./datasets/dataset_epic_full_v100.csv.gz")

#ordeno el dataset
setorder( dataset,  foto_mes )

campos_buenos  <-  setdiff(  colnames( dataset),  c("numero_de_cliente","foto_mes","clase_ternaria" ) )

#campos_buenos <- c("ctrx_quarter", "Visa_mpagospesos")

pdf("./work/boxplots.pdf", 20, 8)
for( campo in  campos_buenos )
{
  tbl   <- dataset[ foto_mes<=202011 ,.SD, .SDcols = c( "foto_mes", "clase_ternaria", campo )]

  print(ggplot(tbl,
               aes(x=as.character(foto_mes), y=get(campo), fill=clase_ternaria)
               ) +
        geom_boxplot() +
        # Por si queremos sacar outliers
        # geom_boxplot(outlier.shape = NA) +
        scale_y_continuous(limits = quantile(tbl[,get(campo)],
                                             c(0.05, 0.95),
                                             na.rm=TRUE)
        ) +
        ggtitle(paste0("Distribuciones - ", campo)) +
        xlab("Período") +
        ylab(campo)
  )
}
dev.off()
