
*** Settings ***
Documentation   Form componennt
Library         Browser
Library         RPA.FileSystem
Library         BuiltIn

*** Variables ***
| #LOCATORS                    |
| ${NAME_LOCATOR}              |  \#firstName
| ${LAST_NAME_LOCATOR}         |  \#lastName
| ${EMAIL_lOCATOR}             |  \#userEmail
| ${RADIO_INPUT_MALE}          |  [for='gender-radio-1']
| ${RADIO_INPUT_FAMALE}        |  [for='gender-radio-2']
| ${RADIO_INPUT_OTHER}         |  [for='gender-radio-3']
| ${SUBJECT_LOCATOR}           |  .subjects-auto-complete__value-container
| ${FIRS_ITEM_OF_SUBJECTS}     |  \#react-select-2-option-0
| ${PHONE_LOCATOR}             |  \#userNumber
| ${DATE_OF_BIRTH}             |  \#dateOfBirthInput
| ${HOBBIES_SPORT}             |  [for='hobbies-checkbox-1']
| ${HOBBIES_READING}           |  [for='hobbies-checkbox-2']
| ${HOBBIES_MUSIC}             |  [for='hobbies-checkbox-3']
| ${UPLOAD_PICTURE}            |  \#uploadPicture
| ${CURRENT_ADDRESS}           |  \#currentAddress
| #STATE LOCATORS              |
| ${STATE_LOCATOR}             |  //div[contains(text(), "Select State")]
#only to use with Select state option keword
| ${STATE_OPTON}               |  \#react-select-3-option-
| #CITY CHOSE LOCATORS         |
| ${CITY_LOCATOR}              |  \#city
#only to use with Select city option keword
| ${CITY_OPTON}                |  \#react-select-4-option-
| ${SUBMIT_BUTTON}             |  \#submit


*** Keywords ***
# user defined keywords

Click submit button
    Click                      ${SUBMIT_BUTTON}  left


Select state option
    [Arguments]                ${nr_option}=0
    ${STATE_LOCATOR_NR}        Catenate  SEPARATOR=  ${STATE_OPTON}  ${nr_option}
    ${text}                    Get Text  ${STATE_LOCATOR_NR}
    Click                      ${STATE_LOCATOR_NR}  left
    RETURN                     ${text}


Select city option
    [Arguments]                ${nr_option}=0
    ${CITY_LOCATOR_NR}         Catenate  SEPARATOR=  ${CITY_OPTON}  ${nr_option}
    ${text}                    Get Text  ${CITY_LOCATOR_NR}
    Click                      ${CITY_LOCATOR_NR}  left
    RETURN                     ${text}


Fill form with data
    # Only named args, before @{} will be positional,
    # lists can't be use like named argumants
    [Arguments]
    ...                        @{}
    ...                        ${SUBJECTS}
    ...                        ${HOBBIES}
    ...                        ${NAME}=Test
    ...                        ${LAST_NAME}=Test
    ...                        ${EMAIL}=test@test.com
    ...                        ${GENDER}=male     # or female or other
    ...                        ${PHONE}=4850123456
    ...                        ${PICTURE_PATH}=.\\test_data\\img.png
    ...                        ${Address}=ul. Cos 45/9 Drno
    ...                        ${STATE_NR_OF_OPTION}=0
    ...                        ${CITY_NR_OF_OPTION}=0

    [Documentation]            Filling form with given data

    Fill Text                  ${NAME_LOCATOR}  ${NAME}
    Fill Text                  ${LAST_NAME_LOCATOR}  ${LAST_NAME}
    Fill Text                  ${EMAIL_LOCATOR}  ${EMAIL}

    # IF comapre two strings, always use "" for variables
    IF  "${GENDER}" == "male"
        Click                  ${RADIO_INPUT_MALE}  left
    ELSE IF  "${GENDER}" == "female"
        Click                  ${RADIO_INPUT_FAMALE}  left
    ELSE IF  "${GENDER}" == "other"
        Click                  ${RADIO_INPUT_OTHER}  left
    ELSE
        FAIL                   Wrong gender value "male, famale or other"
    END

    Fill Text                  ${PHONE_LOCATOR}  ${PHONE}

    FOR  ${item}  IN  @{SUBJECTS}
        Click                  ${SUBJECT_LOCATOR}  left
        # Below how slice text ${item}[0:3]
        Keyboard Input         insertText  ${item}[0:2]
        Click                  ${FIRS_ITEM_OF_SUBJECTS}  left
    END

    FOR  ${item}  IN  @{HOBBIES}
        ${sd}=  Catenate  res:  ${item}
        Log  ${sd}
        IF  "${item}" == "Music"
            Click                  ${HOBBIES_MUSIC}  left
        ELSE IF  "${item}" == "Reading"
            Click                  ${HOBBIES_READING}  left
        ELSE IF  "${item}" == "Sports"
            Click                  ${HOBBIES_SPORT}  left
        ELSE
            FAIL                   Wrong HOBBIE value "Music, Reading or Sports"
        END
    END

    Upload File By Selector    ${UPLOAD_PICTURE}  ${PICTURE_PATH}
    Fill Text                  ${CURRENT_ADDRESS}  ${Address}

    Click                      ${STATE_LOCATOR}  left
    ${State}                   Select state option  nr_option=${STATE_NR_OF_OPTION}
    Click                      ${CITY_LOCATOR}  left
    ${City}                    Select city option  nr_option=${CITY_NR_OF_OPTION}
    &{CITY_AND_STATE}=         Create Dictionary  city=${City}  state=${State}
    RETURN    &{CITY_AND_STATE}


