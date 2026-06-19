# funciones usadas para el ciclo de desarrollo de un paquete de R
# (agregar este archivo a .Rbuildignore)

# chequeos iniciales ----

devtools::has_devel()

devtools::dev_sitrep()

usethis::git_sitrep()

pak::pkg_name_check("nombre")


# crear paquete ----
usethis::create_package("nombre")

# revisar que todo esté bien
devtools::check()


# instalar el propio paquete
# pak::local_install()

# dependencias ----
# agregar dependencia a un paquete
usethis::use_package("dplyr")
usethis::use_package("cli")


# documentos mínimos ----

usethis::use_mit_license()
# usethis::use_gpl3_license()

usethis::use_readme_md()
# usethis::use_readme_rmd()

# repositorio ----
# crear repositorio local
usethis::use_git()

# crear repositorio remoto
usethis::use_github()

# agregar acción de github de chequeo
# usethis::use_github_action("check-standard")

# funciones ----

# crear función
usethis::use_r("territorios")

# crear datos del paquete
usethis::use_data_raw("territorios")


# probar ----

# recargar el paquete
devtools::load_all()

# territorial::territorios


# pruebas ----

# revisar que todo esté bien
devtools::check()

usethis::use_testthat()

# crear test para una función
usethis::use_test("territorios")

# realizar todas las pruebas
devtools::test()


# iteración ----

# crear función
usethis::use_r("comunas")

# recargar paquete
devtools::load_all()

# crear prueba para la función
usethis::use_test("comunas")

# realizar todas las pruebas
devtools::test()

# y repetir


# documentación ----
# escribir documentación
devtools::document()

# crear viñeta
usethis::use_vignette("territorial.qmd") # si se llama como el paquete tiene un rol distinto

# instalar el propio paquete
pak::local_install()
knitr::knit("README.Rmd")

# sitio del paquete
# usethis::use_pkgdown()
# usethis::use_pkgdown_github_pages()

# reconstruir sitio
pkgdown::build_site()
# usethis::use_github_pages()
# poner enlace en _pkdown.yml y description
# usethis::use_github_action("pkgdown")
# cuando se haga push se construirá el sitio


# —----

#
# territorial::comunas()
#
# usethis::use_r("is.comuna.R")
# usethis::use_test("is.comuna.R")
#
# devtools::document()
# devtools::load_all()
# territorial::is.comuna("Maipú")
# devtools::test()
