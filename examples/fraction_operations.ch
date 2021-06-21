fraction_operations:
MODULE
  NEWMODE fraction=STRUCT (num,denum INT);

  add:
    PROC (f1,f2 fraction) RETURNS (fraction) EXCEPTIONS (OVERFLOW);
    RETURN [f1.num*f2.denum+f2.num*f1.denum,f1.denum*f2.denum];
  END add;

  mult:
    PROC (f1,f2 fraction) RETURNS (fraction) EXCEPTIONS (OVERFLOW);
    RETURN [f1.num*f2.num,f2.denum*f1.denum];
  END mult;

  GRANT add, mult;

  SYNMODE operand_mode=fraction;
  GRANT operand_mode;

  SYN neutral_for_add fraction=[ 0,1 ],
      neutral_for_mult fraction=[ 1,1 ];
  GRANT neutral_for_add,
        neutral_for_mult;

END fraction_operations;