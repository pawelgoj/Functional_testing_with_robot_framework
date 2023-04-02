
*** Settings ***
Documentation   Testing student rfill formegistration form
Library         Browser
Library         RPA.FileSystem
Library         BuiltIn
Library         String
Resource         ../resources/form.robot
Resource         ../resources/summary_table.robot
Resource         ../resources/chose_date_component.robot

Test Setup      New Browser  browser=chromium  headless=False  timeout=120
Test Teardown   Close Browser    CURRENT
Suite Teardown  Log  'Done!'


*** Variables ***
| ${PATH_TO_TEST-DATA-DIR}     |  ./test_data/
| #VALUES_TO_FILL_FORM         |
| ${NAME}                      |  Test
| ${SURNAME}                   |  Test
| ${EMAIL}                     |  user@mail.com
| ${Gender}                    |  male
| ${PHONE}                     |  4850123456
| ${month_of_birth}            |  July
| ${day_of_birth}              |  26
| ${year_of_birth}             |  1990
| ${month_of_Birth}            |  July
| ${Picture}                   |  img.png
| ${Address}                   |  ul. Cos 45/9 Drno
| @{SUBJECTS}=                 |  Maths  Chemistry
| @{HOBBIES}=                  |  Sports  Reading  Music
| ${STATE_OPTION_NR}           |  0
| ${CITY_OPTION_NR}            |  0


*** test cases ***
Fill form positive test case
    [Documentation]            It is fill form positive test case
    [Tags]                     Positive test case
    New Context                viewport={'width': 1920, 'height': 1080}  tracing=trace.zip
    New Page                   https://demoqa.com/automation-practice-form

    ${PATH_TO_IMG}             Catenate  SEPARATOR=  ${PATH_TO_TEST-DATA-DIR}  ${Picture}
    # User defined keyword
    &{CITY_AND_STATE}=         Fill form with data  SUBJECTS=@{SUBJECTS}
    ...                                             HOBBIES=@{HOBBIES}
    ...                                             NAME=${NAME}
    ...                                             LAST_NAME=${SURNAME}
    ...                                             GENDER=${Gender}
    ...                                             EMAIL=${EMAIL}
    ...                                             PHONE=${PHONE}
    ...                                             PICTURE_PATH=${PATH_TO_IMG}
    ...                                             Address=${Address}
    ...                                             STATE_NR_OF_OPTION=${STATE_OPTION_NR}
    ...                                             CITY_NR_OF_OPTION=${CITY_OPTION_NR}

    # Logging variables and get value for given key
    # When you have get value from dict use $ instead of &
    Log  ${CITY_AND_STATE.city}
    Log  ${CITY_AND_STATE.state}

    Fill calendar             day_of_month=${day_of_birth}
    ...                       year=${year_of_birth}
    ...                       month=${month_of_Birth}

    Click submit button

    # User defined keyword
    Check data in summary      NAME=${NAME}
    ...                        LAST_NAME=${SURNAME}
    ...                        GENDER=${Gender}
    ...                        EMAIL=${EMAIL}
    ...                        PHONE=${PHONE}
    ...                        PICTURE_PATH=${Picture}
    ...                        Address=${Address}
    ...                        CITY=${CITY_AND_STATE.city}
    ...                        STATE=${CITY_AND_STATE.state}
    ...                        SUBJECTS=@{SUBJECTS}
    ...                        HOBBIES=@{HOBBIES}
    ...                        day_of_month=${day_of_birth}
    ...                        year=${year_of_birth}
    ...                        month=${month_of_Birth}
