import pepita.*
import wollok.vm.*
object rolando {
    var property capacidad = 2
    const morada = castillo
    var poderBase = 5

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

  method poder() {
    return poderBase + self.poderDeArtefactos()
  }

  method poderDeArtefactos() {
    return artefactosConjunto.sum({artefacto => artefacto.poder(self)})
  }
  method poderBase() {
    return poderBase
  }

  method poderBase(_poderBase) {
    poderBase = _poderBase
  }

  method batalla(){
    poderBase += 1
    artefactosConjunto.forEach({artefacto => artefacto.usar()})
  }

  method artefactoInvocado() {
    return morada.artefactoInvocado(self)
  }
}

object espada{
  var nueva = true

  method poder(personaje){
    return personaje.poderBase() * if (nueva) {1} else {0.5}
  }

  method usar() {
    nueva = false
  }
}

object collar{
  var vecesUsadas = 0

  method poder(personaje) {
    return 3 + if (personaje.poderBase() > 6) {self.vecesUsadas()} else {0}
  }

  method usar() {
    vecesUsadas += 1
  }

  method vecesUsadas(){
    return vecesUsadas
  }
}

object bendicion{

  method poder() {
    return 4
  }
}

object invisibilidad {
  
  method poder(personaje) {
    return personaje.poderBase()
  }
}

object invocacion{
  method poder(personaje){

    const artefactosDeMorada = personaje.artefactoInvocado().poder(personaje)
    const artefactoMasPoderoso = artefactosDeMorada.max()({artefacto => artefacto.poder(personaje)})

    return artefactoMasPoderoso.poder(personaje)
  }
}

object libro {
  var property hechizos = []

  method poder() {
    return if (hechizos.isEmpty()) {0} else {hechizos.first().poder()}
  }
  method usar(){
    hechizos = hechizos.drop(1)
  }
}

object armadura{

  method poder(personaje){
    return 6
  }

  method usar(){

  }
}

object castillo {
  const baul = #{}
  
  method depositar(artefactos){
    baul.addAll(artefactos)
  }

  method baul() {
    return baul
  }

  method artefactoInvocado(personaje) {
    return baul.max({artefacto => artefacto.poder(personaje)})
  }
}