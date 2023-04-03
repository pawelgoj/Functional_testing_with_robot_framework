
*** Settings ***
Documentation   Testing student rfill formegistration form
Library         Browser
Library         RPA.FileSystem
Library         BuiltIn
Library         String
Library         FakerLibrary    locale=en_US    seed=666
Library         Collections

Resource        ../resources/form.robot

Test Setup      Setup for test  ${BROWSER}  ${Page_width}  ${Page_hight}

Test Teardown   Close Browser    CURRENT

Suite Teardown  Log  'Done!'


*** Variables ***
| ${PATH_TO_TEST-DATA-DIR}     |  ./test_data/
| ${BROWSER}                   |  chromium
| ${Page_width}                |  1920
| ${Page_hight}                |  1080
| ${Page_url}                  |  https://demoqa.com/automation-practice-form

# Data for form
# If you use pipeline syntax remember about columns for list elements
| @{Genders}=                  |  male | female | other |
| @{SUBJECTS}=                 |  Maths | Chemistry |
| ${Picture}                   |  img.png
| ${STATE_OPTION_NR}           |  0
| ${CITY_OPTION_NR}            |  0
# Normal syntax list declaration
@{HOBBIES}=  Sports  Reading  Music


*** test cases ***
Fill form positive test case
    [Documentation]            It is fill form positive test case
    [Tags]                     Positive test case

    &{CITY_AND_STATE}=               Parametrized test fill form with test data  ${SUBJECTS}  ${HOBBIES}  ${NAME}
    ...                                 ${SURNAME}  ${Gender}  ${EMAIL}  ${PHONE}  ${Address}  ${STATE_OPTION_NR}
    ...                                 ${CITY_OPTION_NR}  ${day_of_birth}  ${year_of_birth}  ${month_of_birth}

    Take Screenshot


*** Keywords ***
