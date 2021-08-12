//EDITOR_MAIN ("find_next")
//C_POINTER($Ptr_resname)

//$Ptr_resname:=OBJECT Get pointer(Object named;"search.list.resname")
//ASSERT(Not(Nil($Ptr_resname)))

EDITOR_SEARCH  // (Choose($Ptr_resname->>0;$Ptr_resname->;0))