import os
import sys

# Nombre archivo: pos 1
# Nombre archivo salida (.ps): pos 2 | default: out.ps

args = sys.argv

if len(args) < 2:
    print("Instrucciones:")
    print("\t- Ingresa el nombre de este script seguido por la ruta a tu archivo.")
    print("\t- [Opcional] Ingresa un segundo argumento que sea la ruta del archivo de salida. (Si no sabes que significa esto no ingreses nada).")
    exit()

fname = args[1]
outname = "out.ps" if len(args) < 3 else args[2]

print("\n")

while True:

    where = input("Donde deseas imprimir?\n1) Salita\n2) Toqui\n3) Cerrar programa\nTu respuesta: ")
    print("\n")
    
    try:
        where = int(where)
        if 1 <= where <= 3:
            break
        else:
            print("\nOpción invalida!\n")

    except ValueError:
        print("\nOpción invalida!\n")

if where == 3:
    exit()

while True:

    cara = input("Cara Simple o Doble?\n1) Simple\n2) Doble\n3) Cerrar programa\nTu respuesta: ")
    print("\n")

    try:
        cara = int(cara)
        if 1 <= cara <= 3:
            break
        else:
            print("\nOpción invalida!\n")

    except ValueError:
        print("\nOpción invalida!\n")

if cara == 3:
    exit()

if cara == 2:
    while True:
        borde = input("Borde Largo o Corto?\n1) Largo\n2) Corto\n3) Cerrar programa\nTu respuesta: ")
        print("\n")

        try:
            borde = int(borde)
            if 1 <= borde <= 3:
                break
            else:
                print("\nOpción invalida!\n")

        except ValueError:
            print("\nOpción invalida!\n")

    if borde == 3:
        exit()

if where == 1: # Salita

    if cara == 1: # Simple
        print_cmd = f"pdf2ps {fname} {outname} && lpr -P hp-335 {outname}"
        how = "en la Salita en Cara Simple."

    elif cara == 2: # Doble

        if borde == 1: # Largo
            print_cmd = f"pdf2ps {fname} {outname} && duplex {outname}|lpr -P hp-335"
            how = "en la Salita en Doble Cara por el Borde Largo."

        elif borde == 2: # Corto
            print_cmd = f"pdf2ps {fname} {outname} && duplex -l {outname}|lpr -P hp-335"
            how = "en la Salita en Doble Cara por el Borde Corto."

elif where == 2: # Toqui

    if cara == 1: # Simple
        print_cmd = f"pdf2ps {fname} {outname} && lpr {outname}"
        how = "en el Toqui en Cara Simple."

    elif cara == 2: # Doble

        if borde == 1: # Largo
            print_cmd = f"pdf2ps {fname} {outname} && duplex {outname}|lpr"
            how = "en el Toqui en Doble Cara por el Borde Largo."

        elif borde == 2: # Corto
            print_cmd = f"pdf2ps {fname} {outname} && duplex -l {outname}|lpr"
            how = "en el Toqui en Doble Cara por el Borde Corto."

print(f"Se ejecutará el comando: {print_cmd}")
print(f"Es decir que se imprimirá {how}\n")

while True:

    r_u_sure_about_that = input("Deseas continuar con la impresión?\n1) Si\n2) No\nTu Respuesta: ")
    print("\n")

    try:

        r_u_sure_about_that = int(r_u_sure_about_that)

        if r_u_sure_about_that == 1:
            os.system(print_cmd)
            print("Comando enviado con éxito!")
            exit()
        elif r_u_sure_about_that == 2:
            exit()
        else:
            print("\nOpción invalida!\n")

    except ValueError:
        print("\nOpción invalida!\n")
