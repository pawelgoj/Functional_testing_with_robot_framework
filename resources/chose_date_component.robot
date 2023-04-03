
*** Settings ***
Documentation   Chose date component
Library         Browser
Library         RPA.FileSystem
Library         BuiltIn
Library         String

| *** Variables ***            |  Locator
| ${DATE_OF_BIRTH}             |  \#dateOfBirthInput
| ${MONTH_LIST_LOCATOR}        |  .react-datepicker__month-select
| ${MONTH_LOCATOR}             |  //select[@class="react-datepicker__month-select"]/option
| ${YEAR_LIST_LOCATOR}         |  .react-datepicker__year-select
| ${YEAR_LOCATOR}              |  //select[@class="react-datepicker__year-select"]/option
| ${DAY_LOCATOR}               |  .react-datepicker__day--0
| ${PREVIOUS_MONTH}            |  .react-datepicker__navigation--previous
| ${NEXT_MONTH}                |  .react-datepicker__navigation--next
| ${SUBJECT_LOCATOR}           |  .subjects-auto-complete__value-container

*** Keywords ***

Fill calendar
    [Arguments]                ${day_of_month}=26
    ...                        ${year}=1990
    ...                        ${month}=May

    Click                      ${DATE_OF_BIRTH}  left
    Chose month                ${month}
    Chose year                 ${year}
    Chose day of the month     ${day_of_month}  ${month}


Chose month
    [Arguments]                ${month}
    Wait For Elements State    ${MONTH_LIST_LOCATOR}  visible  timeout=2 s
    Click                      ${MONTH_LIST_LOCATOR}  left
    Select Options By          ${MONTH_LIST_LOCATOR}  text  ${month}


Chose year
    [Arguments]                ${year}

    Wait For Elements State    ${YEAR_LIST_LOCATOR}  visible  timeout=2 s
    Click                      ${YEAR_LIST_LOCATOR}  left
    Select Options By          ${YEAR_LIST_LOCATOR}   text  ${year}


Chose day of the month
    [Arguments]                ${day}  ${month}

    ${DAY}                     Catenate  SEPARATOR=  ${DAY_LOCATOR}  ${day}
    ${month}=                  Convert To Lower Case  ${month}
    ${elements}=               Get Elements  ${DAY}

    FOR   ${ELEMENT}  IN  @{elements}
        ${atr_value}=          Get Attribute   ${ELEMENT}  aria-label
        ${atr_value}=          Convert To Lower Case  ${atr_value}
        IF  "${month}" in "${atr_value}"
            Click              ${ELEMENT}
            BREAK
        END
    END


