FROM rocker/rstudio:4.1.1

# system libraries of general use
RUN apt-get update && apt-get install -y \
	libxml2 \
	libxml2-dev \
	&& apt-get clean \
	&& rm -rf /tmp/* /var/lib/apt/lists/*

    

# Install R packages
RUN install2.r  --error \
	aRxiv \
	medrxivr \
	dplyr \
	wordcloud \
	RCurl \
	rentrez \
	rmarkdown \
	SnowballC \
	svglite \
	tidyr \
	tm \
	devtools
RUN R -e "update.packages()"
RUN R -e "devtools::install_github('haozhu233/kableExtra')"

EXPOSE 8787	
