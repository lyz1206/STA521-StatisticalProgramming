all: hw5.html

hw5.html: hw5.Rmd data/lq.rds data/dennys.rds
	Rscript -e "rmarkdown::render('hw5.Rmd')"

data/lq.rds: data/lq/*.json parse_lq.R
	Rscript parse_lq.R

data/dennys.rds: data/dennys/*.html parse_dennys.R
	Rscript parse_dennys.R

data/lq/*.json: get_lq.R
	Rscript get_lq.R

data/dennys/*.html: get_dennys.R
	Rscript get_dennys.R

clean:
	rm -f hw5.html
	rm -rf data/
