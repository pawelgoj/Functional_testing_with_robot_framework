
*** Settings ***
Documentation   Testing student rfill formegistration form
Library         Browser
Library         RPA.FileSystem
Library         BuiltIn
Library         String
Library         FakerLibrary    locale=en_US    seed=666
Library         Collections

Resource        ../resources/form.robot
Resource        ../resources/summary_table.robot
Resource        ../resources/chose_date_component.robot
Resource        ../resources/utils.robot

Test Setup      Setup For Test  ${BROWSER}  ${Page_width}  ${Page_hight}

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

    &{CITY_AND_STATE}=               Parametrized Test Fill Form With Test Data  ${SUBJECTS}  ${HOBBIES}  ${NAME}
    ...                                 ${SURNAME}  ${Gender}  ${EMAIL}  ${PHONE}  ${Address}  ${STATE_OPTION_NR}
    ...                                 ${CITY_OPTION_NR}  ${day_of_birth}  ${year_of_birth}  ${month_of_birth}

    # User defined keyword
    Check Data In Summary      NAME=${NAME}
    ...                        LAST_NAME=${SURNAME}
    ...                        GENDER=${Gender}
    ...                        EMAIL=${EMAIL}
    ...                        PHONE=${PHONE}
    ...                        PICTURE_PATH=${Picture}
    ...                        Address=${Address}
    ...                        CITY=${CITY_AND_STATE.city}
    ...                        STATE=${CITY_AND_STATE.state}
    ...                        SUBJECTS=${SUBJECTS}
    ...                        HOBBIES=${HOBBIES}
    ...                        day_of_month=${day_of_birth}
    ...                        year=${year_of_birth}
    ...                        month=${month_of_birth}
    Take Screenshot


# Data driven tes case using template
The user forgot to fill in all required data
    [Documentation]                  It is fill form negative test case
    [Tags]                           negative test case
    # Empty [Setup] this test dont use setup of tests
    [Setup]      Set Test random data
    # template for data driven test, one test diferent data
    # ${EMPTY} is special Robot Framework value represents the empty strin
    [Template]   Parametrized test fill form wrong test data and check response
    ${SUBJECTS}  ${HOBBIES}  ${EMPTY}  ${SURNAME}  ${Gender}
    ...          ${EMAIL}  ${PHONE}  ${Address}  ${STATE_OPTION_NR}  ${CITY_OPTION_NR}
    ...          ${day_of_birth}  ${year_of_birth}  ${month_of_birth}
    ${SUBJECTS}  ${HOBBIES}  ${NAME}  ${EMPTY}  ${Gender}
    ...          ${EMAIL}  ${PHONE}  ${Address}  ${STATE_OPTION_NR}  ${CITY_OPTION_NR}
    ...          ${day_of_birth}  ${year_of_birth}  ${month_of_birth}
    ${SUBJECTS}  ${HOBBIES}  ${NAME}  ${SURNAME}  ${Gender}
    ...          ${EMPTY}  ${PHONE}  ${Address}  ${STATE_OPTION_NR}  ${CITY_OPTION_NR}
    ...          ${day_of_birth}  ${year_of_birth}  ${month_of_birth}
    ${SUBJECTS}  ${HOBBIES}  ${NAME}  ${SURNAME}  ${Gender}
    ...          ${EMAIL}  ${EMPTY}  ${Address}  ${STATE_OPTION_NR}  ${CITY_OPTION_NR}
    ...          ${day_of_birth}  ${year_of_birth}  ${month_of_birth}
    ${SUBJECTS}  ${HOBBIES}  ${NAME}  ${SURNAME}  ${Gender}
    ...          ${EMAIL}  ${PHONE}  ${EMPTY}  ${STATE_OPTION_NR}  ${CITY_OPTION_NR}
    ...          ${day_of_birth}  ${year_of_birth}  ${month_of_birth}
    [Teardown]


The user enters the wrong email
    [Tags]                           negative test case
    ${EMAIL}=                        FakerLibrary.Random Letters   	length=8
    Parametrized test fill form wrong test data and check response  ${SUBJECTS}  ${HOBBIES}  ${NAME}  ${SURNAME}  ${Gender}
    ...                                                             ${EMAIL}  ${PHONE}  ${Address}  ${STATE_OPTION_NR}  ${CITY_OPTION_NR}
    ...                                                             ${day_of_birth}  ${year_of_birth}  ${month_of_birth}




The user enters the wrong phone number
    [Tags]                     negative test case
    ${PHONE}=                  FakerLibrary.Random Number  digits=9  fix_len=True
    ${PHONE}=                  Convert To String  ${PHONE}
    Parametrized Test Fill Form Wrong Test Data And Check Response  ${SUBJECTS}  ${HOBBIES}  ${NAME}  ${SURNAME}  ${Gender}
    ...                                                             ${EMAIL}  ${PHONE}  ${Address}  ${STATE_OPTION_NR}  ${CITY_OPTION_NR}
    ...                                                             ${day_of_birth}  ${year_of_birth}  ${month_of_birth}

    ${PHONE}=                  FakerLibrary.Random Letters   	length=10
    Parametrized Test Fill Form Wrong Test Data And Check Response  ${SUBJECTS}  ${HOBBIES}  ${NAME}  ${SURNAME}  ${Gender}
    ...                                                             ${EMAIL}  ${PHONE}  ${Address}  ${STATE_OPTION_NR}  ${CITY_OPTION_NR}
    ...                                                             ${day_of_birth}  ${year_of_birth}  ${month_of_birth}



*** Keywords ***
# Define setup for tests
Setup For Test
    [Arguments]  ${BROWSER}  ${Page_width}  ${Page_hight}

    Get web browser  ${BROWSER}  ${Page_width}  ${Page_hight}
    Set Test random data

Get Web Browser
    [Arguments]  ${BROWSER}  ${Page_width}  ${Page_hight}

    New Browser  browser=${BROWSER}  headless=True  timeout=120
    New Context  viewport={'width': ${Page_width}, 'height': ${Page_hight}}  tracing=trace.zip
    # Open new page
    New Page     ${Page_url}

Set Test Random Data
    # Returned data from Make random data for test
    ${NAME}  ${SURNAME}  ${EMAIL}
    ...  ${Address}  ${Gender}
    ...  ${PHONE}  ${year_of_birth}
    ...  ${month_of_birth}
    ...  ${day_of_birth}             Make random data for test  ${Genders}

    # Return variables for tests
    Set Test Variable  ${NAME}  ${NAME}
    Set Test Variable  ${SURNAME}  ${SURNAME}
    Set Test Variable  ${EMAIL}  ${EMAIL}
    Set Test Variable  ${Address}  ${Address}
    Set Test Variable  ${Gender}   ${Gender}
    Set Test Variable  ${PHONE}  ${PHONE}
    Set Test Variable  ${year_of_birth}  ${year_of_birth}
    Set Test Variable  ${month_of_birth}  ${month_of_birth}
    Set Test Variable  ${day_of_birth}  ${day_of_birth}


Parametrized Test Fill Form With Test Data
    [Arguments]  ${SUBJECTS}  ${HOBBIES}  ${NAME}  ${SURNAME}  ${Gender}
    ...          ${EMAIL}  ${PHONE}  ${Address}  ${STATE_OPTION_NR}  ${CITY_OPTION_NR}
    ...          ${day_of_birth}  ${year_of_birth}  ${month_of_birth}

    ${PATH_TO_IMG}=      Catenate  SEPARATOR=  ${PATH_TO_TEST-DATA-DIR}  ${Picture}

    # Fill Form With Data is user defined keyword from form resources
    &{CITY_AND_STATE}=   Fill Form With Data  SUBJECTS=${SUBJECTS}
    ...                                       HOBBIES=${HOBBIES}
    ...                                       NAME=${NAME}
    ...                                       LAST_NAME=${SURNAME}
    ...                                       GENDER=${Gender}
    ...                                       EMAIL=${EMAIL}
    ...                                       PHONE=${PHONE}
    ...                                       PICTURE_PATH=${PATH_TO_IMG}
    ...                                       Address=${Address}
    ...                                       STATE_NR_OF_OPTION=${STATE_OPTION_NR}
    ...                                       CITY_NR_OF_OPTION=${CITY_OPTION_NR}

    # Logging variables and get value for given key
    # When you have get value from dict use $ instead of &
    Log                        ${CITY_AND_STATE.city}
    Log                        ${CITY_AND_STATE.state}

    Fill Calendar              day_of_month=${day_of_birth}
    ...                        year=${year_of_birth}
    ...                        month=${month_of_birth}

    Click Submit Button
    RETURN                     &{CITY_AND_STATE}


Parametrized Test Fill Form Wrong Test Data And Check Response
    [Arguments]  ${SUBJECTS}  ${HOBBIES}  ${NAME}  ${SURNAME}  ${Gender}
    ...          ${EMAIL}  ${PHONE}  ${Address}  ${STATE_OPTION_NR}  ${CITY_OPTION_NR}
    ...          ${day_of_birth}  ${year_of_birth}  ${month_of_birth}
    Get web browser  ${BROWSER}  ${Page_width}  ${Page_hight}

    Parametrized Test Fill Form With Test Data  ${SUBJECTS}  ${HOBBIES}  ${NAME}  ${SURNAME}
    ...          ${Gender}  ${EMAIL}  ${PHONE}  ${Address}  ${STATE_OPTION_NR}
    ...          ${CITY_OPTION_NR}  ${day_of_birth}  ${year_of_birth}  ${month_of_birth}

    Check Sumarry Is Not Show
    Take Screenshot
    # When we used keyword in Template, this keyword must have [Teardown]
    # If we want make something after each iteration
    Close Browser    CURRENT