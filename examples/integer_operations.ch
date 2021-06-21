integer_operations:
MODULE

  add:
    PROC (i,j INT) RETURNS (INT) EXCEPTIONS (OVERFLOW);
    RESULT i+j;
  END add;

  mult:
    PROC (i,j INT) RETURNS (INT) EXCEPTIONS (OVERFLOW);
    RESULT i*j;
  END mult;

  GRANT add, mult;

  SYNMODE operand_mode=INT;
  GRANT operand_mode;

  SYN neutral_for_add=0,
      neutral_for_mult=1;
  GRANT neutral_for_add,
        neutral_for_mult;

END integer_operations;