
*** Settings ***
Documentation   Testing student rfill formegistration form
Library         Browser
Library         RPA.FileSystem
Library         BuiltIn
Library         String
Library         FakerLibrary    locale=en_US    seed=666
Library         Collections

Resource         ../resources/form.robot
Resource         ../resources/summary_table.robot
Resource         ../resources/chose_date_component.robot

Test Setup      New Browser  browser=chromium  headless=False  timeout=120
Test Teardown   Close Browser    CURRENT
Suite Teardown  Log  'Done!'


*** Variables ***
| ${PATH_TO_TEST-DATA-DIR}     |  ./test_data/
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
    # Generate some random data
    ${NAME}=                   FakerLibrary.Name
    ${SURNAME}=                FakerLibrary.Last Name
    ${EMAIL}=                  FakerLibrary.Email
    ${Address}=                FakerLibrary.Address
    # Use python code to get random item from list, random is python module
    ${Gender}=                 Evaluate   random.choice($Genders)   modules=random
    ${PHONE}=                  FakerLibrary.Random Number  digits=10  fix_len=True
    ${PHONE}=                  Convert To String  ${PHONE}
    ${year_of_birth}=          FakerLibrary.Random Int  min=1990  max=2100  step=1
    ${year_of_birth}=          Convert To String  ${year_of_birth}

    ${month_of_birth}=         FakerLibrary.Month Name
    ${day_of_birth}=           FakerLibrary.Random Int  min=1  max=28  step=1
    ${day_of_birth}=           Convert To String  ${day_of_birth}

    # Open new page
    New Context                viewport={'width': 1920, 'height': 1080}  tracing=trace.zip
    New Page                   https://demoqa.com/automation-practice-form

    ${PATH_TO_IMG}             Catenate  SEPARATOR=  ${PATH_TO_TEST-DATA-DIR}  ${Picture}

    # Fill form with data is user defined keyword from form resources
    &{CITY_AND_STATE}=         Fill form with data  SUBJECTS=${SUBJECTS}
    ...                                             HOBBIES=${HOBBIES}
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
    ...                       month=${month_of_birth}

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
    ...                        SUBJECTS=${SUBJECTS}
    ...                        HOBBIES=${HOBBIES}
    ...                        day_of_month=${day_of_birth}
    ...                        year=${year_of_birth}
    ...                        month=${month_of_birth}




Fill form negative test case
    [Documentation]            It is fill form negative test case
    [Tags]                     negative test case