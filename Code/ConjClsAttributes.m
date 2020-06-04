intrinsic label(C::LMFDBGrpConjCls) -> MonStgElt
  {}
  gp_label := Get(C, "group");
  o := Get(C, "MagmaConjCls")[1];
  // J := capital_letter_code(C) ? TODO
  //return Sprintf("%o.%o%o", gp_label, o, J);
  return Sprintf("%o.%o", gp_label, o);
end intrinsic;

intrinsic group(C::LMFDBGrpConjCls) -> MonStgElt
  {return label of ambient group of C}
  CC := Get(C, "MagmaConjCls");
  return label(Parent(CC[3]));
end intrinsic;

intrinsic size(C::LMFDBGrpConjCls) -> Any
  {}
  CC := Get(C, "MagmaConjCls");
  return CC[2];
end intrinsic;

// TODO
intrinsic counter(C::LMFDBGrpConjCls) -> Any
  {}
  return false;
end intrinsic;

intrinsic order(C::LMFDBGrpConjCls) -> Any
  {}
  CC := Get(C, "MagmaConjCls");
  return CC[1];
end intrinsic;

// TODO
// not sure how to do this...
// supposed to return label for centralizer as subgroup of ambient group
intrinsic centralizer(C::LMFDBGrpConjCls) -> Any
  {}
  gp_label := Get(C, "group");
  //G := LoadGrp(gp_label, );
  g := Get(C, "representative");
  Z := Centralizer(g);
  GG := Parent(g);
  return Centralizer(g); // TODO: fix this
end intrinsic;

// TODO
intrinsic powers(C::LMFDBGrpConjCls) -> Any
  {}
  return false;
end intrinsic;

intrinsic representative(C::LMFDBGrpConjCls) -> Any
  {}
  CC := Get(C, "MagmaConjCls");
  return CC[3]; // this may need to change depending on how elts are represented in ambient group
end intrinsic;