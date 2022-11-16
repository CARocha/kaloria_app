module ApplicationHelper
    $alfabeto_mayusculas = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    $alfabeto_minusculas = "abcdefghijklmnopqrstuvwxyz"
    $longitud_alfabeto = 26
    $limite_inferior_mayusculas = 65
    $limite_inferior_minusculas = 97
    def cipher_cesar(string_email, rotation, orientation = 1)
        chain_with_rotation = ""
        for letra in string_email.chars
            if !letra.match(/^[[:alpha:]]$/)
                chain_with_rotation += letra
                next
            end
            alfabeto = $alfabeto_mayusculas
            limite = $limite_inferior_mayusculas
            if letra == letra.downcase
                alfabeto = $alfabeto_minusculas
                limite = $limite_inferior_minusculas
            end

            valor_ascii = letra.ord
            rotation_verdaderas = rotation * orientation
            nueva_posicion = (valor_ascii - limite + rotation_verdaderas) % $longitud_alfabeto
            chain_with_rotation += alfabeto[nueva_posicion]
        end
        chain_with_rotation
    end
end
