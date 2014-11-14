###
# Informaatio kriteeri k‰ytt‰‰ kaavaa:
# AIC(testi,k=log(length(ts1960))
#

laskuM <- function(aikasarja) {

	tulosmatriisi <- matrix(0, nrow = 6, ncol = 6,
		dimnames = list(c(0:5),c(0:5))); tulosmatriisi

	for(i in 0:5) {
		for(j in 0:5) {
				try(tulosmatriisi[(i+1),(j+1)] <- laskuBIC(i,j,aikasarja), TRUE)

		}
	}

#printataan tai output
tulosmatriisi
}

####
# Informaatio kriteerin laskeminen mallille
#
laskuBIC <- function(i, j,aikasarja){
	bicmalli  <- arima(aikasarja, order=c(i,0,j), include.mean=FALSE)
  BICtulos <-  AIC(bicmalli,k=log(length(aikasarja)))
}