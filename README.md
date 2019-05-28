# gamlj_docs
Documentation for [gamlj](https://github.com/gamlj/gamlj)
Read it [here](https://gamlj.github.io/)


This repository contains the source of the docs published in [gamlj docs page](https://gamlj.github.io/) and some handy function to produce, mantain and publish the docs. Feel free to use them to produce your own docs for your application.

# Usage of code

## The docs structure

We use `Rmarkdown::render_site()` function so the structure of the docs is decided by the way you set up the site (see `Rmarkdown::render_site()` documentation). In short, one goes to the `\docsource` folder and set up the docs site rendering in the `_site_yml` file. 

As an example, here we set up a site with two main pages (GLM and Mixed) and their corresponding file. In the `docsource` directory each file must have a corresponding .Rmd file in which the markdown is present.
```
name: "gamlj-website"
output_dir: "../pubs"
navbar:
  title: "GAMLj"
  left:
  - text: "GLM"
    href:  glm.html
  - text: "Mixed"
    href: mixed.html
output:
  html_document:
    css: style.css
    theme: flatly

```

In the `output` key one can put the .css style sheet and the theme. The .css file must be in the `docsource` folder. When the .Rmd files are ready, one can run `Rmarkdown::render_site()` to get the html files. However, one can use some of the functions in `R/` to automatize the process.

# Docs for a project

The idea is two have two different github repos for the project and the docs. 

TO BE CONTINUED


