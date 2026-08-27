# =========================================================================
# SECCIÓN DE DATOS
# =========================================================================
.data
    # Caso de prueba: puedes cambiar los textos para probar distintos resultados
    str1: .asciiz "hola"
    str2: .asciiz "hola"

# =========================================================================
# SECCIÓN DE CÓDIGO
# =========================================================================
.text
.globl main

main:
    # Pasamos los dos argumentos a la función
    la $a0, str1        # $a0 = dirección de la primera cadena (s)
    la $a1, str2        # $a1 = dirección de la segunda cadena (t)
    
    jal mi_strcmp
    
    # El resultado regresa en $v0. Vamos a imprimirlo en la consola.
    move $a0, $v0       # Movemos el resultado a $a0 para imprimirlo
    li $v0, 1           # Código de sistema para imprimir un entero
    syscall
    
    # Terminar programa
    li $v0, 10
    syscall

# -------------------------------------------------------------------------
# FUNCIÓN: mi_strcmp (Clon de strcmp de C)
# Argumentos: $a0 = char *s, $a1 = char *t
# Retorna:    $v0 = 0 (iguales), positivo (s > t), negativo (s < t)
# -------------------------------------------------------------------------
mi_strcmp:
bucle:
    lb $t0, 0($a0)      # Lee un carácter de la cadena 's'
    lb $t1, 0($a1)      # Lee un carácter de la cadena 't'

    # Condición de salida 1: Si son diferentes, rompemos el ciclo para calcular la resta
    bne $t0, $t1, calcular_diferencia

    # Condición de salida 2: Si son iguales pero llegamos al final del string ('\0')
    # Como ya sabemos que $t0 == $t1, si $t0 es cero, ambos son cero.
    beq $t0, $zero, cadenas_iguales

    # Avanzar los punteros a la siguiente letra (1 byte)
    addi $a0, $a0, 1
    addi $a1, $a1, 1
    j bucle

calcular_diferencia:
    # Restamos los valores ASCII (s[i] - t[i])
    # Si s[i] > t[i] -> el resultado será positivo (ej. 'o' > 'a')
    # Si s[i] < t[i] -> el resultado será negativo (ej. 'a' < 'o')
    sub $v0, $t0, $t1
    jr $ra

cadenas_iguales:
    # Si el bucle terminó porque llegó a un cero sin encontrar diferencias
    li $v0, 0
    jr $ra
