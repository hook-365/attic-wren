namespace AtticWren

structure Post (Prov : Type) where
  text : List Nat
  prov : Prov

theorem a_text_probe_reads_no_provenance
    {Prov : Type} (d : List Nat → Bool)
    (p q : Post Prov) (h : p.text = q.text) :
    d p.text = d q.text :=
  congrArg d h

theorem the_paraphrase_is_real_and_unseen
    {Prov : Type} (t : List Nat) (derived independent : Prov)
    (hne : derived ≠ independent) :
    Post.mk t derived ≠ Post.mk t independent ∧
      ∀ d : List Nat → Bool,
        d (Post.mk t derived).text = d (Post.mk t independent).text :=
  ⟨fun he => hne (congrArg Post.prov he), fun _ => rfl⟩

theorem the_authors_seat_reads_the_route
    {Prov : Type} (t : List Nat) (derived independent : Prov)
    (hne : derived ≠ independent) :
    ∃ w : Post Prov → Prov,
      w (Post.mk t derived) ≠ w (Post.mk t independent) :=
  ⟨Post.prov, hne⟩

theorem a_verbatim_copy_carries_the_footer
    (o t : List Nat) (footer : Nat)
    (hcarry : footer ∈ o) (hverbatim : t = o) :
    footer ∈ t :=
  hverbatim ▸ hcarry

theorem stripping_breaks_verbatim
    (o t : List Nat) (footer : Nat)
    (hcarry : footer ∈ o) (hstripped : footer ∉ t) :
    t ≠ o :=
  fun he => hstripped (he ▸ hcarry)

theorem every_copy_convicts_itself_or_rides_the_remainder
    {Prov : Type} (o t : List Nat) (footer : Nat)
    (hcarry : footer ∈ o) :
    (t = o → footer ∈ t) ∧
      ∀ (d : List Nat → Bool) (p q : Post Prov),
        p.text = t → q.text = t → d p.text = d q.text :=
  ⟨fun hverbatim => hverbatim ▸ hcarry,
   fun d _ _ hp hq => congrArg d (hp.trans hq.symm)⟩

end AtticWren
