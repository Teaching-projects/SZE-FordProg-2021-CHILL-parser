parser grammar ChillParser;

options {
    tokenVocab=ChillLexer;
}

program
    : ( module
    | specModule
    | region
    | specRegion
    | moretaDeclarationStatement
    | moretaSynmodeDefinitionStatement
    | moretaNewmodeDefinitionStatement
    | template
    )+
    ;

module
    : contextList? definingOccurrence?
      MODULE BODY? moduleBody END
      handler? SIMPLE_NAME_STRING? SC
    | remoteModulion
    | genericModuleInstantiation
    ;

specModule
    : simpleSpecModule
    | moduleSpec
    | remoteSpec
    ;

region
    : contextList? definingOccurrence?
      REGION BODY? regionBody END
      handler? SIMPLE_NAME_STRING? SC
    | remoteModulion
    | genericRegionInstantiation
    ;

specRegion
    : simpleSpecRegion
    | regionSpec
    | remoteSpec
    ;

template
    : genericModuleTemplate
    | genericRegionTemplate
    | genericProcedureTemplate
    | genericProcessTemplate
    | genericModuleModeTemplate
    | genericRegionModeTemplate
    | genericTaskModeTemplate
    | genericInterfaceModeTemplate
    | remoteProgramUnit
    ;

contextList
    : context (context)*
    | remoteContext
    ;

definingOccurrence
    : SIMPLE_NAME_STRING;

moduleBody
    : (dataStatement | visibilityStatement | region |
      specRegion)* actionStatementList
    ;

handler
    : ON (onAlternative )* (ELSE actionStatementList)? END
    ;

onAlternative
    : LPAREN exceptionList RPAREN COLON actionStatementList
    ;

remoteModulion
    : (SIMPLE_NAME_STRING COLON)? REMOTE pieceDesignator SC
    ;

genericModuleInstantiation
    : SIMPLE_NAME_STRING COLON MODULE = NEW genericModuleName
      seizeStatement* actualGenericParameterList END
      SIMPLE_NAME_STRING? SC
    ;

simpleSpecModule
    : contextList? (SIMPLE_NAME_STRING COLON)? SPEC MODULE
      specModuleBody END SIMPLE_NAME_STRING? SC
    ;

moduleSpec
    : contextList? SIMPLE_NAME_STRING COLON MODULE SPEC
      specModuleBody END SIMPLE_NAME_STRING? SC
    ;

remoteSpec
    : (SIMPLE_NAME_STRING COLON)? SPEC REMOTE pieceDesignator SC
    ;

regionBody
    : (dataStatement | visibilityStatement)*
    ;

genericRegionInstantiation
    : SIMPLE_NAME_STRING COLON REGION = NEW genericRegionName
     (seizeStatement)*
      actualGenericParameterList END SIMPLE_NAME_STRING? SC
    ;

simpleSpecRegion
    : contextList? (SIMPLE_NAME_STRING COLON)? SPEC REGION
      specRegionBody END SIMPLE_NAME_STRING? SC
    ;

regionSpec
    : contextList? SIMPLE_NAME_STRING COLON REGION SPEC
      specRegionBody END SIMPLE_NAME_STRING? SC
    ;

context
    : CONTEXT contextBody FOR
    ;

remoteContext
    : CONTEXT REMOTE pieceDesignator
      contextBody? FOR
    ;

dataStatement
    : declarationStatement
    | definitionStatement
    ;

visibilityStatement
    : grantStatement
    | seizeStatement
    ;

actionStatementList
    : actionStatement*
    ;

exceptionList
    : exceptionName (COMMA exceptionName)*
    ;

pieceDesignator
    : characterStringLiteral
    | textReferenceName
    | empty
    ;

seizeStatement
    : SEIZE prefixRenameClause ( COMMA prefixRenameClause)* SC
    | SEIZE seizeWindow prefixClause? SC
    ;

actualGenericParameterList
    : actualGenericParameter actualGenericParameter*
    ;

specModuleBody
    : (quasiDataStatement | visibilityStatement |
       specModule | specRegion )*
    ;

specRegionBody
    : (quasiDataStatement | visibilityStatement)*
    ;

contextBody
    : (quasiDataStatement | visibilityStatement |
       specModule | specRegion)*
    ;

declarationStatement
    : DCL declaration ( COMMA declaration)* SC
    ;

definitionStatement
    : synmodeDefinitionStatement
    | newmodeDefinitionStatement
    | synonymDefinitionStatement
    | procedureDefinitionStatement
    | processDefinitionStatement
    | signalDefinitionStatement
    | template
    | empty SC
    ;

grantStatement
    : GRANT prefixRenameClause (COMMA prefixRenameClause)* SC
    | GRANT grantWindow prefixClause? friendClause? SC
    ;

actionStatement
    : (definingOccurrence COLON)? action handler? SIMPLE_NAME_STRING? SC
    | module
    | specModule
    | contextModule
    ;

exceptionName
    : SIMPLE_NAME_STRING
    | prefixedNameString
    ;

textReferenceName
    : SIMPLE_NAME_STRING
    | prefixedNameString
    ;

empty
    :
    ;

prefixRenameClause
    : LPAREN oldPrefix ARROW newPrefix RPAREN EXCLAMATION_MARK postfix
    ;

seizeWindow
    : seizePostfix (COMMA seizePostfix)*
    ;

prefixClause
    : PREFIXED prefix?
    ;

actualGenericParameter
    : synonymDefinitionStatement
    | synmodeDefinitionStatement
    | newmodeDefinitionStatement
    | actualGenericProcedure
    ;

characterStringLiteral
    : narrowCharacterStringLiteral
    | wideCharacterStringLiteral
    ;

quasiDataStatement
    : quasiDeclarationStatement
    | quasiDefinitionStatement
    ;

declaration
    : locationDeclaration
    | locIdentityDeclaration
    ;

synmodeDefinitionStatement
    : SYNMODE modeDefinition (COMMA modeDefinition)* SC
    | remoteProgramUnit
    ;

newmodeDefinitionStatement
    : NEWMODE modeDefinition (COMMA modeDefinition)* SC
    | remoteProgramUnit
    ;

synonymDefinitionStatement
    : SYN synonymDefinition (COMMA synonymDefinition)* SC
    ;

procedureDefinitionStatement
    : definingOccurrence COLON procedureDefinition
      handler? SIMPLE_NAME_STRING? SC
    | genericProcedureInstantiation
    ;

processDefinitionStatement
    : definingOccurrence COLON processDefinition
      handler? SIMPLE_NAME_STRING? SC
    | genericProcessInstantiation SC
    ;

signalDefinitionStatement
    : SIGNAL signalDefinition (COMMA signalDefinition)* SC
    ;

grantWindow
    : grantPostfix (COMMA grantPostfix)*
    ;

friendClause
    : TO friendNameList
    ;

action
    : bracketedAction
    | assignmentAction
    | callAction
    | exitAction
    | returnAction
    | resultAction
    | gotoAction
    | assertAction
    | emptyAction
    | startAction
    | stopAction
    | delayAction
    | continueAction
    | sendAction
    | causeAction
    ;

contextModule
    : CONTEXT MODULE REMOTE pieceDesignator SC
    ;

prefixedNameString
    : prefix EXCLAMATION_MARK SIMPLE_NAME_STRING
    ;

oldPrefix
    : prefix
    | empty
    ;

newPrefix
    : prefix
    | empty
    ;

postfix
    : seizePostfix (COMMA seizePostfix)*
    | grantPostfix (COMMA grantPostfix)*
    ;

seizePostfix
    : nameString (LPAREN formalParameterList RPAREN (RETURNS? LPAREN resultSpec RPAREN)?)?
    | (prefix EXCLAMATION_MARK)? ALL
    ;

prefix
    : simplePrefix ( EXCLAMATION_MARK simplePrefix)*
    ;

actualGenericProcedure
    : PROC definingOccurrenceList EQL procedureName SC
    ;

narrowCharacterStringLiteral
    : QUOTATION_MARK (NON_RESERVED_CHARACTER | quote | controlSequence)* QUOTATION_MARK
    ;

wideCharacterStringLiteral
    : ('W\''|'w\'') QUOTATION_MARK (NON_RESERVED_WIDE_CHARACTER | quote | controlSequence)* QUOTATION_MARK
    ;

quasiDeclarationStatement
    : DCL quasiDeclaration (COMMA quasiDeclaration)* SC
    ;

quasiDefinitionStatement
    : synmodeDefinitionStatement
    | newmodeDefinitionStatement
    | synonymDefinitionStatement
    | quasiSynonymDefinitionStatement
    | quasiProcedureDefinitionStatement
    | quasiProcessDefinitionStatement
    | quasiSignalDefinitionStatement
    | signalDefinitionStatement
    | empty SC
    ;

locationDeclaration
    : definingOccurrenceList mode_ STATIC? initialization?
    ;

mode_
    : READ? nonCompositeMode
    | READ? compositeMode
    | formalGenericModeIndication
    ;

locIdentityDeclaration
    : definingOccurrenceList mode_ LOC DYNAMIC?
      assignmentSymbol location handler?
    ;

modeDefinition
    : definingOccurrenceList EQL definingMode
    ;

remoteProgramUnit
    : ( SIMPLE_NAME_STRING COLON )? REMOTE pieceDesignator SC
    ;

synonymDefinition
    : definingOccurrenceList mode_? EQL constantValue
    ;

procedureDefinition
    : PROC LPAREN (formalParameterList)? RPAREN resultSpec?
     (EXCEPTIONS LPAREN exceptionList RPAREN)? procedureAttributeList SC
      procBody END
    ;

genericProcedureInstantiation
    : SIMPLE_NAME_STRING COLON PROC = NEW genericProcedureName
      seizeStatement* actualGenericParameterList END
      SIMPLE_NAME_STRING? SC
    ;

genericProcessInstantiation
    : SIMPLE_NAME_STRING COLON PROCESS = NEW genericProcessName
      seizeStatement* actualGenericParameterList END
      SIMPLE_NAME_STRING? SC
    ;

processDefinition
    : PROCESS LPAREN formalParameterList? RPAREN  processBody END
    ;

signalDefinition
    : definingOccurrence (EQL LPAREN mode_ (COMMA mode_)* RPAREN )? (TO processName)?
    ;

grantPostfix
    : nameString ( LPAREN parameterList RPAREN (RETURNS? LPAREN resultSpec RPAREN)?)?
    | newmodeNameString forbidClause
    | (prefix EXCLAMATION_MARK)? ALL
    ;

friendNameList
    : friendName (COMMA friendName)*
    ;

bracketedAction
    : ifAction
    | caseAction
    | doAction
    | beginEndBlock
    | delayCaseAction
    | receiveCaseAction
    | timingAction
    ;

assignmentAction
    : singleAssignmentAction
    | multipleAssignmentAction
    ;

singleAssignmentAction
    : location assignmentSymbol value
    | location assigningOperator expression
    ;

expression
    : operand0
    | conditionalExpression
    ;

operand0
    : operand1
    | subOperand0 (OR | ORIF | XOR) operand1
    ;

subOperand0
    : operand0;

operand1
    : operand2
    | subOperand1 (AND | ANDIF) operand2
    ;

subOperand1
    : operand1
    ;

operand2
    : operand3
    | subOperand2 operator3 operand3
    ;

subOperand2
    : operand2
    ;

operator3
    : relationalOperator
    | membershipOperator
    | powersetInclusionOperator
    ;

relationalOperator
    : EQL | NE | GT | GTE | LT | LTE
    ;
membershipOperator
    : IN
    ;

powersetInclusionOperator
    : LTE | GTE | LT | GT
    ;

operand3
    : operand4
    | subOperand3 operator4 operand4
    ;

subOperand3
    : operand3
    ;

operator4
    : arithmeticAdditiveOperator
    | stringConcatenationOperator
    | powersetDifferenceOperator
    ;

operand4
    : operand5
    | subOperand4 arithmeticMultiplicativeOperator operand5
    ;

subOperand4
    : operand4
    ;

operand5
    : operand6
    | subOperand5 exponentiationOperator operand6
    ;

subOperand5
    : operand5
    ;

exponentiationOperator
    : EXPO
    ;

operand6
    : monadicOperator? operand7
    | signedIntegerLiteral
    | signedFloatingPointLiteral
    ;

integerLiteral
    : unsignedIntegerLiteral
    | signedIntegerLiteral
    ;

unsignedIntegerLiteral
    : decimalIntegerLiteral
    | binaryIntegerLiteral
    | octalIntegerLiteral
    | hexadecimalIntegerLiteral
    ;

signedIntegerLiteral
    : SUB unsignedIntegerLiteral
    ;

decimalIntegerLiteral
    : DECIMAL_LITERAL
    ;

binaryIntegerLiteral
    : BINARY_LITERAL
    ;

octalIntegerLiteral
    : OCT_LITERAL
    ;

hexadecimalIntegerLiteral
    : HEX_LITERAL
    ;

digitSequence
    : (DIGIT | UNDERSCORE)+
    ;

floatingPointLiteral
    : unsignedFloatingPointLiteral
    | signedFloatingPointLiteral
    ;

unsignedFloatingPointLiteral
    : digitSequence DOT digitSequence? exponent?
    | digitSequence? DOT digitSequence exponent?
    ;

signedFloatingPointLiteral
    : SUB unsignedFloatingPointLiteral
    ;

exponent
    : E digitSequence
    | E SUB digitSequence
    ;

monadicOperator
    : SUB | NOT
    | stringRepetitionOperator
    ;

stringRepetitionOperator
    : LPAREN integerLiteralExpression RPAREN
    ;

operand7
    : referencedLocation
    | primitiveValue
    ;

primitiveValue
    : locationContents
    | valueName
    | literal
    | tuple
    | valueStringElement
    | valueStringSlice
    | valueArrayElement
    | valueArraySlice
    | valueStructureField
    | expressionConversion
    | representationConversion
    | valueProcedureCall
    | valueBuiltInRoutineCall
    | startExpression
    | zeroAdicOperator
    | parenthesizedExpression
    ;

parenthesizedExpression
    : LAPREN expression RPAREN
    ;

zeroAdicOperator
    : THIS
    ;

startExpression
    : START processName LPAREN actualParameterList? RPAREN
    ;

actualParameterList
    : actualParameter (COMMA actualParameter )*
    ;

actualParameter
    : value
    | location
    ;

valueProcedureCall
    : valueProcedureCall
    ;

valueBuiltInRoutineCall
    : valueBuiltInRoutineCall;

representationConversion
    : modeName LAPREN expression RPAREN
    ;

expressionConversion
    : modeName HASHTAG LPAREN expression RPAREN
    ;

valueStructureField
    : structurePrimitiveValue DOT fieldName
    ;

fieldName
    : SIMPLE_NAME_STRING
    ;

valueArrayElement
    : arrayPrimitiveValue LPAREN expressionList RPAREN
    ;

valueArraySlice
    : arrayPrimitiveValue LPAREN lowerElement COLON upperElement RPAREN
    | arrayPrimitiveValue LPAREN firstElement UP sliceSize RPAREN
    ;

valueStringSlice
    : stringPrimitiveValue LPAREN leftElement COLON rightElement RPAREN
    | stringPrimitiveValue LPAREN startElement UP sliceSize RPAREN
    ;

locationContents
    : location
    ;

valueName
    : synonymName
    | valueEnumerationName
    | valueDoWithName
    | valueReceiveName
    | generalProcedureName
    ;

literal
    : integerLiteral
    | floatingPointLiteral
    | booleanLiteral
    | characterLiteral
    | setLiteral
    | emptinessLiteral
    | characterStringLiteral
    | bitStringLiteral
    ;

bitStringLiteral
    : binaryBitStringLiteral
    | octalBitStringLiteral
    | hexadecimalBitStringLiteral
    ;

binaryBitStringLiteral
    : BINARY_LITERAL_PREFIX BINARY_NUMBER STRING_CHAR_PREFIX
    ;

octalBitStringLiteral
    : OCT_LITERAL_PREFIX OCT_NUMBER STRING_CHAR_PREFIX
    ;

hexadecimalBitStringLiteral
    : HEX_LITERAL_PREFIX HEX_NUMBER STRING_CHAR_PREFIX
    ;

emptinessLiteral
    : emptinessLiteralName
    ;

//TODO check [predefined]
emptinessLiteralName
    : NULL
    ;

setLiteral
    : (modeName DOT)? setElementName
    ;

setElementName
    : SIMPLE_NAME_STRING
    ;

characterLiteral
    : narrowCharacterLiteral
    | wideCharacterLiteral
    ;

narrowCharacterLiteral
    : STRING_CHAR_PREFIX ( character | controlSequence ) STRING_CHAR_PREFIX
    ;

wideCharacterLiteral
    : WIDE_CHAR_PREFIX ( character | controlSequence ) STRING_CHAR_PREFIX
    ;

//TODO check
character
    : LETTER
    ;

booleanLiteral
    : booleanLiteralName
    ;

//TODO check [predefined]
booleanLiteralName
    : TRUE
    | FALSE
    ;

tuple
    : (modeName)? LPC (powersetTuple | arrayTuple | structureTuple) RPC
    ;

 powersetTuple
    :  ((expression | range) (COMMA (expression | range))*)?
    ;

 range
    : expression COLON expression
    ;

 arrayTuple
    : unlabelledArrayTuple
    | labelledArrayTuple
    ;

 unlabelledArrayTuple
    : value (COMMA value)*
    ;

labelledArrayTuple
    : caseLabelList COLON value (COMMA caseLabelList COLON value)*
    ;

caseLabelList
    : LPAREN caseLabel (COMMA caseLabel )* RPAREN
    | irrelevant
    ;

caseLabelSpecification
    : caseLabelList (COMMA caseLabelList )*
    ;

caseLabel
    : discreteLiteralExpression
    | literalRange
    | discreteModeName
    | ELSE
    ;

literalRange
    : lowerBound COLON upperBound
    ;

lowerBound
    : discreteLiteralExpression
    ;

upperBound
    : discreteLiteralExpression
    ;


irrelevant
    : LPAREN MUL RPAREN
    ;


structureTuple
    : unlabelledStructureTuple
    | labelledStructureTuple
    ;

 unlabelledStructureTuple
    : value (COMMA value )*
    ;

 labelledStructureTuple
    : fieldNameList COLON value (COMMA fieldNameList COLON value )*
    ;

 fieldNameList
    : DOT fieldName (COMMA DOT fieldName )*
    ;

valueStringElement
    : stringPrimitiveValue LPAREN startElement RPAREN
    ;

startElement
    : integerExpression
    ;

referencedLocation
    : ARROW location
    ;

conditionalExpression
    : IF booleanExpression thenAlternative
      elseAlternative FI
    | CASE caseSelectorList OF (valueCaseAlternative)+
     (ELSE subExpression)? ESAC
    ;

thenAlternative
    : THEN subExpression
    ;

elseAlternative
    : ELSE subExpression
    | ELSIF booleanExpression
      thenAlternative elseAlternative
    ;

subExpression
    : expression
    ;

valueCaseAlternative
    : caseLabelSpecification COLON subExpression SC
    ;

multipleAssignmentAction
    : location (COMMA location)+ assignmentSymbol value
    ;

assigningOperator
    : closedDyadicOperator assignmentSymbol
    ;

closedDyadicOperator
    : OR | XOR | AND
    | powersetDifferenceOperator
    | arithmeticAdditiveOperator
    | arithmeticMultiplicativeOperator
    | stringConcatenationOperator
    ;

powersetDifferenceOperator
    : SUB
    ;

arithmeticAdditiveOperator
    : PLUS
    | SUB
    ;

arithmeticMultiplicativeOperator
    : MUL | DIV | MOD | REM
    ;

stringConcatenationOperator
    : CONCAT
    ;

callAction
    : procedureCall
    | builtInRoutineCall
    | moretaComponentProcedureCall
    ;

exitAction
    : EXIT labelName
    ;

returnAction
    : RETURN result?
    ;

resultAction
    : RESULT result?
    ;

result
    : value
    | location
    ;

gotoAction
    : GOTO labelName
    ;

assertAction
    : ASSERT booleanExpression;

emptyAction
    : empty
    ;

startAction
    : startExpression
    ;

stopAction
    : STOP
    ;

delayAction
    : DELAY eventLocation priority?
    ;

priority
    : PRIORITY integerLiteralExpression
    ;

continueAction
    : CONTINUE eventLocation
    ;

sendAction
    : sendSignalAction
    | sendBufferAction
    ;

causeAction
    : CAUSE exceptionName
    ;

nameString
    : SIMPLE_NAME_STRING
    | prefixedNameString
    ;

formalParameterList
    : formalParameter (COMMA formalParameter)*
    ;

resultSpec
    : RETURNS LPAREN mode_ resultAttribute? RPAREN
    ;

simplePrefix
    : SIMPLE_NAME_STRING
    ;

definingOccurrenceList
    : definingOccurrence (COMMA definingOccurrence)*
    ;

quote
    : QUOTATION_MARK QUOTATION_MARK
    ;

controlSequence
    : CIRCUMFLEX LPAREN integerLiteralExpression ( COMMA integerLiteralExpression)* RPAREN
    | CIRCUMFLEX nonSpecialCharacter
    | CIRCUMFLEX
    ;

quasiDeclaration
    : quasiLocationDeclaration
    | quasiLocIdentityDeclaration
    ;

quasiSynonymDefinitionStatement
    : SYN quasiSynonymDefinition (COMMA quasiSynonymDefinition)* SC
    ;

quasiProcedureDefinitionStatement
    : definingOccurrence COLON PROC LPAREN quasiFormalParameterList? RPAREN
      resultSpec? ( EXCEPTIONS LPAREN exceptionList RPAREN)?
      procedureAttributeList ( END ( SIMPLE_NAME_STRING )?)? SC
    ;

quasiProcessDefinitionStatement
    : definingOccurrence COLON PROCESS LPAREN quasiFormalParameterList? RPAREN
     (END SIMPLE_NAME_STRING?)? SC
    ;

quasiSignalDefinitionStatement
    : SIGNAL quasiSignalDefinition (COMMA quasiSignalDefinition)* SC
    ;

initialization
    : reachBoundInitialization
    | lifetimeBoundInitialization
    | moretaBoundInitialization
    ;

nonCompositeMode
    : discreteMode
    | realMode
    | powersetMode
    | referenceMode
    | procedureMode
    | instanceMode
    | synchronizationMode
    | inputOutputMode
    | timingmode
    ;

compositeMode
    : stringMode
    | arrayMode
    | structureMode
    | moretaMode
    ;

formalGenericModeIndication
    : ANY
    | ANY_ASSIGN
    | ANY_DISCRETE
    | ANY_INT
    | ANY_REAL
    | moretaModeName
    ;

assignmentSymbol
    : ASGN
    ;

location
    : accessName
    | dereferencedBoundReference
    | dereferencedFreeReference
    | dereferencedRow
    | stringElement
    | stringSlice
    | arrayElement
    | arraySlice
    | structureField
    | locationProcedureCall
    | locationBuiltInRoutineCall
    | locationConversion
    | predefinedMoretaLocation
    ;

definingMode
    : mode_
    ;

procedureAttributeList
    : generality?
    ;

generality
    : GENERAL
    | SIMPLE
    | INLINE
    ;

procBody
    : dataStatementList actionStatementList
    ;

processBody
    : dataStatementList actionStatementList
    ;

parameterList
    : parameterSpec (COMMA parameterSpec)*
    ;

forbidClause
    : FORBID (forbidNameList | ALL)
    ;

friendName
    : modulionOrMoretaModeName (EXCLAMATION_MARK friendProcedureOrProcessName)?
    ;

ifAction
    : IF booleanExpression thenClause (elseClause)? FI
    ;

thenClause
    : THEN actionStatementList
    ;

elseClause
    : ELSE actionStatementList
    | ELSIF booleanExpression thenClause (elseClause)?
    ;

caseAction
    : CASE caseSelectorList OF (rangeList SC)? (caseAlternative)+
      (ELSE actionStatementList)? ESAC
    ;

caseSelectorList
    : discreteExpression (COMMA discreteExpression)*
    ;

rangeList
    : discreteModeName (COMMA discreteModeName)*
    ;

caseAlternative
    : caseLabelSpecification COLON actionStatementList
    ;

doAction
    : DO (controlPart SC)? actionStatementList OD
    ;

controlPart
    : forControl (whileControl)?
    | whileControl
    | withPart
    ;

beginEndBlock
    : BEGIN beginEndBody END
    ;

delayCaseAction
    : DELAY CASE ( SET instanceLocation (priority)? SC | <priority> SC )?
    ( delayAlternative )+ ESAC
    ;

delayAlternative
    : LPAREN eventList RPAREN COLON actionStatementList
    ;

eventList
    : eventLocation (COMMA eventLocation )*
    ;

receiveCaseAction
    : receiveSignalCaseAction
    | receiveBufferCaseAction
    ;

receiveSignalCaseAction
    : RECEIVE CASE (SET instanceLocation SC )?
     (signalReceiveAlternative)+
     (ELSE actionStatementList)? ESAC
    | RECEIVE (SET instanceLocation)?
      LPAREN signalName (IN locationList)? RPAREN
    ;

locationList
    : location (COMMA location)*
    ;

signalReceiveAlternative
    :
    LAPREN signalName (IN defining occurrence list)? RPAREN COLON actionStatementList
    ;

timingAction
    : relativeTimingAction
    | absoluteTimingAction
    | cyclicTimingAction
    ;

relativeTimingAction
    : AFTER durationPrimitiveValue (DELAY)? IN
      actionStatementList timingHandler END
    ;

timingHandler
    : TIMEOUT actionStatementList
    ;

absoluteTimingAction
    : AT absoluteTimePrimitiveValue IN
      actionStatementList timingHandler END
    ;

cyclicTimingAction
    : CYCLE durationPrimitiveValue IN
      actionStatementList END
    ;

value
    : expression
    | undefinedValue
    ;

undefinedValue
    : MUL
    | undefinedSynonymName
    ;