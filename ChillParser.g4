grammar ChillParser;

import ChillLexer;

program
    : module+ EOF
    ;

module
    : contextList? (definingOccurrence COLON)?
      MODULE BODY? moduleBody END
      handler? SIMPLE_NAME_STRING? SC
    ;

contextList
    : context (context)*
    | remoteContext
    ;

definingOccurrence
    : SIMPLE_NAME_STRING;

moduleBody
    : (dataStatement | visibilityStatement)* actionStatementList
    ;

handler
    : ON (onAlternative )* (ELSE actionStatementList)? END
    ;

onAlternative
    : LPAREN exceptionList RPAREN COLON actionStatementList
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

contextBody
    : (quasiDataStatement | visibilityStatement)*
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
    | empty SC
    ;

grantStatement
    : GRANT prefixRenameClause (COMMA prefixRenameClause)* SC
    | GRANT grantWindow prefixClause? friendClause? SC
    ;

friendClause
    : TO friendNameList
    ;

friendNameList
    : friendName (COMMA friendName)*
    ;

friendName
    : modulionOrMoretaModeName (EXCLAMATION_MARK friendProcedureOrProcessName)
    ;

modulionOrMoretaModeName
    : modulionName
    | moretaModeName
    ;

friendProcedureOrProcessName
    : procedureName (LPAREN parameterList RPAREN ((RETURNS)? LPAREN resultSpec RPAREN)?)?
    | processName
    ;

actionStatement
    : (definingOccurrence COLON)? action handler? SIMPLE_NAME_STRING? SC
    | module
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
    ;

processDefinitionStatement
    : definingOccurrence COLON processDefinition
      handler? SIMPLE_NAME_STRING? SC
    ;

signalDefinitionStatement
    : SIGNAL signalDefinition (COMMA signalDefinition)* SC
    ;

grantWindow
    : grantPostfix (COMMA grantPostfix)*
    ;

//friendClause
//    : TO friendNameList
//    ;

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
    : WIDE_CHARACTER_PREFIX QUOTATION_MARK (NON_RESERVED_WIDE_CHARACTER | quote | controlSequence)* QUOTATION_MARK
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
    : PROC LPAREN formalParameterList? RPAREN resultSpec?
     (EXCEPTIONS LPAREN exceptionList RPAREN)? procedureAttributeList SC
      procBody END
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
//
//friendNameList
//    : friendName (COMMA friendName)*
//    ;

bracketedAction
    : ifAction
    | caseAction
//    | doAction
//    | beginEndBlock
//    | delayCaseAction
//    | receiveCaseAction
//    | timingAction
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
    | operand0 (OR | ORIF | XOR) operand1
    ;

operand1
    : operand2
    | operand1 (AND | ANDIF) operand2
    ;

operand2
    : operand3
    | operand2 operator3 operand3
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
    | operand3 operator4 operand4
    ;

operator4
    : arithmeticAdditiveOperator
    | stringConcatenationOperator
    | powersetDifferenceOperator
    ;

operand4
    : operand5
    | operand4 arithmeticMultiplicativeOperator operand5
    ;

operand5
    : operand6
    | operand5 exponentiationOperator operand6
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
//    | valueName
    | literal
    | tuple
//    | valueStringElement
//    | valueStringSlice
//    | valueArrayElement
//    | valueArraySlice
    | valueStructureField
//    | valueProcedureCall
//    | valueBuiltInRoutineCall
    | startExpression
    | zeroAdicOperator
    | parenthesizedExpression
    ;

parenthesizedExpression
    : LPAREN expression RPAREN
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

//valueProcedureCall
//    : valueProcedureCall
//    ;
//
//valueBuiltInRoutineCall
//    : valueBuiltInRoutineCall;

valueStructureField
    : structurePrimitiveValue DOT fieldName
    ;

fieldName
    : SIMPLE_NAME_STRING
    ;

//valueArrayElement
//    : arrayPrimitiveValue LPAREN expressionList RPAREN
//    ;
//
//valueArraySlice
//    : arrayPrimitiveValue LPAREN lowerElement COLON upperElement RPAREN
//    | arrayPrimitiveValue LPAREN firstElement UP sliceSize RPAREN
//    ;
//
//valueStringSlice
//    : stringPrimitiveValue LPAREN leftElement COLON rightElement RPAREN
//    | stringPrimitiveValue LPAREN startElement UP sliceSize RPAREN
//    ;

locationContents
    : location
    ;

//valueName
//    : synonymName
//    | valueEnumerationName
//    | valueDoWithName
//    | valueReceiveName
//    | generalProcedureName
//    ;

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
    : NULL_LITERAL
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
//    : discreteLiteralExpression
//    : literalRange
    : discreteModeName
    | ELSE
    ;

//literalRange
//    : lowerBound COLON upperBound
//    ;

//lowerBound
//    : discreteLiteralExpression
//    ;

//upperBound
//    : discreteLiteralExpression
//    ;


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
    ;

procedureCall
    : procedureName LPAREN actualParameterList? RPAREN
    ;

builtInRoutineCall
    : builtInRoutineName LPAREN builtInRoutineParameterList? RPAREN
    ;

builtInRoutineParameterList
    : builtInRoutineParameter (COMMA builtInRoutineParameter)*
    ;

builtInRoutineParameter
    : value
    | location
    | nonReservedName  ( LPAREN COMMA builtInRoutineParameterList RPAREN)?
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

priority
    : PRIORITY integerLiteralExpression
    ;

sendAction
    : sendSignalAction
    ;

sendSignalAction
    : SEND signalName (LPAREN value (COMMA value)* RPAREN )?
      TO instancePrimitiveValue priority?
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

formalParameter
    : definingOccurrenceList parameterSpec
    ;

parameterSpec
    : mode_  parameterAttribute?
    ;

parameterAttribute
    : IN | OUT | INOUT | LOC DYNAMIC?
    ;

resultSpec
    : RETURNS LPAREN mode_ resultAttribute? RPAREN
    ;

resultAttribute
    : NONREF? LOC DYNAMIC?
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
//    | CIRCUMFLEX nonSpecialCharacter
    | CIRCUMFLEX NON_RESERVED_CHARACTER //TODO check
    | CIRCUMFLEX
    ;

quasiDeclaration
    : quasiLocationDeclaration
    | quasiLocIdentityDeclaration
    ;

quasiLocationDeclaration
    : definingOccurrenceList mode_
    ;

quasiLocIdentityDeclaration
    : definingOccurrenceList mode_
      LOC NONREF? DYNAMIC?
    ;

quasiSynonymDefinitionStatement
    : SYN quasiSynonymDefinition (COMMA quasiSynonymDefinition)* SC
    ;

quasiSynonymDefinition
    : definingOccurrenceList (mode_ EQL constantValue? |  mode_? EQL literalExpression)
    ;

quasiProcedureDefinitionStatement
    : definingOccurrence COLON PROC LPAREN quasiFormalParameterList? RPAREN
      resultSpec? ( EXCEPTIONS LPAREN exceptionList RPAREN)?
      procedureAttributeList ( END ( SIMPLE_NAME_STRING )?)? SC
    ;

quasiFormalParameterList
    : quasiFormalParameter (COMMA quasiFormalParameter)*
    ;

quasiFormalParameter
    : SIMPLE_NAME_STRING (COMMA SIMPLE_NAME_STRING)* parameterSpec
    ;

quasiProcessDefinitionStatement
    : definingOccurrence COLON PROCESS LPAREN quasiFormalParameterList? RPAREN
     (END SIMPLE_NAME_STRING?)? SC
    ;

quasiSignalDefinitionStatement
    : SIGNAL quasiSignalDefinition (COMMA quasiSignalDefinition)* SC
    ;

quasiSignalDefinition
    : definingOccurrence (EQL LPAREN mode_ (COMMA mode_)* RPAREN )? (TO)?
    ;

initialization
    : reachBoundInitialization
    | lifetimeBoundInitialization
    ;

reachBoundInitialization
    : assignmentSymbol value handler?
    ;

lifetimeBoundInitialization
    : INIT assignmentSymbol constantValue
    ;

nonCompositeMode
    : discreteMode
    | realMode
//    | powersetMode
//    | referenceMode
//    | procedureMode
//    | instanceMode
//    | synchronizationMode
//    | inputOutputMode
//    | timingmode
    ;

realMode
    : floatingPointMode
//    | floatingPointRangeMode
    ;

floatingPointMode
    : FLOATING_POINT_MODE_NAME
    ;

discreteMode
    : integerMode
    | booleanMode
    | characterMode
    | setMode
//    | discreteRangeMode
    ;

integerMode
    : INTEGER_MODE_NAME
    ;

booleanMode
    : booleanModeName
    ;

characterMode
    : CHARACTER_MODE_NAME
    ;

setMode
    : SET LPAREN setList RPAREN
    | setModeName
    ;

setList
    : numberedSetList
    | unnumberedSetList
    ;

numberedSetList
    : numberedSetElement (COMMA numberedSetElement)*
    ;

numberedSetElement
    : setElementNameDefiningOccurrence EQL integerLiteralExpression
    ;

unnumberedSetList
    : setElement (COMMA setElement)*
    ;

setElement
    : setElementNameDefiningOccurrence
    ;

compositeMode
    : stringMode
    | arrayMode
//    | structureMode
    ;

arrayMode
    : ARRAY LPAREN indexMode (COMMA indexMode)* RPAREN
      elementMode (elementLayout)*
    | parameterizedArrayMode
    | arrayModeName
    ;

elementLayout
    : PACK | NOPACK | step
    ;

fieldLayout
    : PACK | NOPACK | pos
    ;


step
    : STEP LPAREN pos (COMMA stepSize)? RPAREN
    ;

pos
    : POS LPAREN word COMMA startBit COMMA length RPAREN
    | POS LPAREN word (COMMA startBit (COLON endBit)? )? RPAREN
    ;

word
    : integerLiteralExpression
    ;

stepSize
    : integerLiteralExpression
    ;

startBit
    : integerLiteralExpression
    ;

endBit
    : integerLiteralExpression
    ;

length
    : integerLiteralExpression
    ;

parameterizedArrayMode
    : originArrayModeName LPAREN upperIndex RPAREN
    | parameterizedArrayModeName
    ;

originArrayModeName
    : arrayModeName
    ;

upperIndex
    : discreteLiteralExpression
    ;

indexMode
    : discreteMode
    | literalRange
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

elementMode
    : mode_
    ;

stringMode
    : STRING_TYPE LPAREN stringLength RPAREN VARYING?
    | parameterizedStringMode
    | stringModeName
    ;

parameterizedStringMode
    : originStringModeName LPAREN stringLength RPAREN
    | parameterizedStringModeName
    ;

originStringModeName
    : stringModeName
    ;


stringLength
    : integerLiteralExpression
    ;

formalGenericModeIndication
    : ANY
    | ANY_ASSIGN
    | ANY_DISCRETE
    | ANY_INT
    | ANY_REAL
    ;

assignmentSymbol
    : ASGN
    ;

location
//    : accessName
//    | dereferencedBoundReference
//    | dereferencedFreeReference
//    | dereferencedRow
//    | stringElement
//    | stringSlice
//    | arrayElement
//    | arraySlice
//    | structureField
//    | locationProcedureCall
//    | locationBuiltInRoutineCall
//    | locationConversion
//    | predefinedMoretaLocation
    : SIMPLE_NAME_STRING
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

dataStatementList
    : dataStatement*
    ;

parameterList
    : parameterSpec (COMMA parameterSpec)*
    ;

forbidClause
    : FORBID (forbidNameList | ALL)
    ;

forbidNameList
    : LPAREN fieldName (COMMA fieldName)* RPAREN
    ;

//friendName
//    : modulionOrMoretaModeName (EXCLAMATION_MARK friendProcedureOrProcessName)?
//    ;

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

//doAction
//    : DO (controlPart SC)? actionStatementList OD
//    ;

//controlPart
//    : forControl (whileControl)?
//    | whileControl
//    | withPart
//    ;

//beginEndBlock
//    : BEGIN beginEndBody END
//    ;

//delayCaseAction
//    : DELAY CASE (SET instanceLocation (priority)? SC | <priority> SC )?
//    (delayAlternative)+ ESAC
//    ;

//delayAlternative
//    : LPAREN eventList RPAREN COLON actionStatementList
//    ;

//eventList
//    : eventLocation (COMMA eventLocation )*
//    ;

//receiveCaseAction
//    : receiveSignalCaseAction
//    | receiveBufferCaseAction
//    ;

//receiveSignalCaseAction
//    : RECEIVE CASE (SET instanceLocation SC )?
//     (signalReceiveAlternative)+
//     (ELSE actionStatementList)? ESAC
//    | RECEIVE (SET instanceLocation)?
//      LPAREN signalName (IN locationList)? RPAREN
//    ;

//locationList
//    : location (COMMA location)*
//    ;

//signalReceiveAlternative
//    : LPAREN signalName (IN defining occurrence list)? RPAREN COLON actionStatementList
//    ;

//timingAction
//    : relativeTimingAction
//    | absoluteTimingAction
//    | cyclicTimingAction
//    ;

//relativeTimingAction
//    : AFTER durationPrimitiveValue (DELAY)? IN
//      actionStatementList timingHandler END
//    ;

//timingHandler
//    : TIMEOUT actionStatementList
//    ;

//absoluteTimingAction
//    : AT absoluteTimePrimitiveValue IN
//      actionStatementList timingHandler END
//    ;

//cyclicTimingAction
//    : CYCLE durationPrimitiveValue IN
//      actionStatementList END
//    ;

value
    : expression
    | undefinedValue
    ;

undefinedValue
    : MUL
//    | undefinedSynonymName
    ;



//Need further check, temporarily replaced with simpler elemetns
procedureName
    : SIMPLE_NAME_STRING
    ;

processName
    : SIMPLE_NAME_STRING
    ;

constantValue
    : SIMPLE_NAME_STRING
    | integerLiteral
    ;

literalExpression
    : SIMPLE_NAME_STRING
    | integerLiteral
    ;

newmodeNameString
    : SIMPLE_NAME_STRING
    ;

integerLiteralExpression
    : integerLiteral
    ;

structurePrimitiveValue
    : SIMPLE_NAME_STRING
    ;

modeName
    : SIMPLE_NAME_STRING
    ;

discreteModeName
    : SIMPLE_NAME_STRING
    ;

builtInRoutineName
    : SIMPLE_NAME_STRING
    ;

nonReservedName
    : SIMPLE_NAME_STRING
    ;

labelName
    : SIMPLE_NAME_STRING
    ;

signalName
    : SIMPLE_NAME_STRING
    ;

instancePrimitiveValue
    : SIMPLE_NAME_STRING
    ;

setElementNameDefiningOccurrence
    : SIMPLE_NAME_STRING
    ;

setModeName
    : SIMPLE_NAME_STRING
    ;

arrayModeName
    : SIMPLE_NAME_STRING
    ;

parameterizedArrayModeName
    : SIMPLE_NAME_STRING
    ;

discreteLiteralExpression
    : SIMPLE_NAME_STRING
    | integerLiteralExpression
    ;

parameterizedStringModeName
    : SIMPLE_NAME_STRING
    ;

stringModeName
    : SIMPLE_NAME_STRING
    ;

discreteExpression
    : SIMPLE_NAME_STRING
    ;

modulionName
    : SIMPLE_NAME_STRING
    ;

moretaModeName
    : SIMPLE_NAME_STRING
    ;

//TODO check, as these are only the predefined
booleanModeName
    : BOOL
    ;

// Found this one on stackoverflow
// https://stackoverflow.com/questions/30976962/nested-boolean-expression-parser-using-antlr
booleanExpression
 : LPAREN expression RPAREN                       #parenExpression
 | NOT expression                                 #notExpression
 | left=expression op=comparator right=expression #comparatorExpression
 | left=expression op=binary right=expression     #binaryExpression
 | BOOL_LITERAL                                   #boolExpression
 | SIMPLE_NAME_STRING                             #identifierExpression
 | DECIMAL_NUMBER                                 #decimalExpression
 ;

comparator
 : GT | GTE | LT | LTE | EQL
 ;


binary
 : AND | OR
 ;



