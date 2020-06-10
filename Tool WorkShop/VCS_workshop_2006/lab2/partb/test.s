alias tb show -value a_test b_test cin_test cout_test sum_test
alias vars show -value a b sum sum_0 sum_1 cin c4 zero_add_cin one_add_cin

scope u1
force zero_add_cin 1
force one_add_cin 0
vars
scope -up
