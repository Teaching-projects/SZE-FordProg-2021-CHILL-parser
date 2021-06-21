complex_operations:
  MODULE

  NEWMODE complex=STRUCT (re,im FLOAT);

  add:
    PROC (c1,c2 complex) RETURNS (complex) EXCEPTIONS (OVERFLOW);
    RETURN [c1.re+c2.re,c1.im+c2.im];
  END add;

  mult:
    PROC (c1,c2 complex) RETURNS (complex) EXCEPTIONS (OVERFLOW);
    RETURN [c1.re*c2.re-c1.im*c2.im,c1.re*c2.im+c1.im*c2.re];
  END mult;

  GRANT add, mult;

  SYNMODE operand_mode=complex;
  GRANT   operand_mode;

  SYN neutral_for_add=complex [ 0.0,0.0 ],
      neutral_for_mult=complex [ 1.0,0.0 ];
  GRANT neutral_for_add,
        neutral_for_mult;

END complex_operations;