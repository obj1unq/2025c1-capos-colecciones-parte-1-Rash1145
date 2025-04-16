object rolando {
    var capacidad = 2
    const morada = castillo

    method incrementarCapacidad(_capacidad){
        capacidad+= _capacidad
    }

    const artefactosLista = [] //listas List reverse() size() remove()
    const artefactosConjunto = #{} //conjunto Set
  
  method artefactosLista() {
    return artefactosLista
  }

  method artefactosConjunto() {
    return artefactosConjunto
  }

  method recoger(artefacto){
    artefactosConjunto.add(artefacto)
  }

  method encontrar(artefacto){
    if (self.tieneEspacio()){
        self.recoger(artefacto)
    }
    artefactosLista.add(artefacto)
  }

  method tieneEspacio(){
    return artefactosConjunto.size() < capacidad
  }

  method irAMorada() {
    morada.depositar(artefactosConjunto)
    artefactosConjunto.clear()
    //artefactos.removeAll(artefactos)
  }

  method posesiones(){
    return artefactosConjunto + morada.baul()
  }
}

object espada{

}

object collar{

}

object libro {
  
}

object armadura{

}

object castillo {
  const baul = #{}
  
  method depositar(artefactos){
    baul.addAll(artefactos)
  }

  method baul() {
    return baul
  }
}