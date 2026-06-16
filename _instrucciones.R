Paquetes

devtools::has_devel()

devtools::dev_sitrep()

usethis::git_sitrep()

pak::pkg_name_check("minipkg3")

usethis::create_package("../minipkg3")

usethis::use_mit_license()

devtools::check()

usethis::use_r("territorios")

usethis::use_data_raw("territorios")

devtools::load_all()

# comunal::territorios

usethis::use_testthat()
usethis::use_test("territorios")

devtools::test()

usethis::use_r("comunas")
usethis::use_test("comunas")

devtools::document()
devtools::load_all()
comunal::comunas()

usethis::use_r("is.comuna.R")
usethis::use_test("is.comuna.R")

devtools::document()
devtools::load_all()
comunal::is.comuna("Maipú")
devtools::test()

usethis::use_package("dplyr")
# usethis::use_package("praise")

usethis::use_git()

usethis::use_github()

# usethis::use_github_action("check-standard")
