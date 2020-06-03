intrinsic IsSemidirectProduct(G::LMFDBGrp : direct := false) -> Any
  {Returns true if G is a nontrivial semidirect product; otherwise returns false.}
  dirbool := false;
  GG := Get(G, "MagmaGrp");
  ordG := Get(G, "Order");
  Ns := NormalSubgroups(GG); // TODO: this should be changed to call on subgroup database when it exists
  Remove(~Ns,#Ns); // remove full group;
  Remove(~Ns,1); // remove trivial group;
  if direct then
    Ks := Ns;
  else
    Ks := Subgroups(GG); // this should be changed to call on subgroup database when it exists
  end if;
  for r in Ns do
    N := r`subgroup;
    comps := [el : el in Ks | el`order eq (ordG div Order(N))];
    for s in comps do
      K := s`subgroup;
      if #(N meet K) eq 1 then
        return true;
        //print N, K;
      end if;
    end for;
  end for;
  return dirbool;
end intrinsic;

intrinsic IsDirectProduct(G::LMFDBGrp) -> Any
  {Returns true if G is a nontrivial direct product; otherwise returns false.}
  return IsSemidirectProduct(G : direct := true);
end intrinsic;

intrinsic ComputeAllSplittings(G::LMFDBGrp) -> Any
  {Compute all splittings of G as a semidirect product}
  GG := Get(G, "MagmaGrp");
  ordG := Get(G, "Order");
  Ns := NormalSubgroups(GG); // TODO: this should be changed to call on subgroup database when it exists
  Remove(~Ns,#Ns); // remove full group;
  Remove(~Ns,1); // remove trivial group;
  Ks := Subgroups(GG); // this should be changed to call on subgroup database when it exists
  splittings := [];
  for r in Ns do
    N := r`subgroup;
    comps := [el : el in Ks | el`order eq (ordG div Order(N))];
    for s in comps do
      K := s`subgroup;
      if #(N meet K) eq 1 then
        Append(~splittings, [N,K]);
      end if;
    end for;
  end for;
  return splittings;
end intrinsic;

intrinsic IsWreathProduct(G::LMFDBGrp) -> Any
  {Returns true if G is a wreath product; otherwise returns false.}
  if not Get(G, "IsSemidirectProduct") then
    return false;
  end if;
  return IsSemidirectProduct(G : direct := true);
end intrinsic;

intrinsic SchurMultiplier(G::LMFDBGrp) -> Any
  {}
  invs := [];
  ps := FactorsOfOrder(G);
  GG := Get(G, "MagmaGrp");
  for p in ps do
    for el in pMultiplicator(GG,p) do // handbook claims pMultiplicator works for GrpFin, but in Magma only for GrpPerm...
      if el gt 1 then
        Append(~invs, el);
      end if;
    end for;
  end for;
  return invs;
end intrinsic;
