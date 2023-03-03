#!/usr/bin/env bash

while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
  -h | --help )
    echo "Uso:"
    echo -e "\t printer.sh [FILE1] [FILE2]\n"
    echo "Parametros:"
    echo -e "\t - FILE1: Ruta del archivo que deseas imprimir"
    echo -e "\t - FILE2 [opcional]: Ruta del archivo de salida."
    exit
    ;;
esac; shift; done

if (( $# < 1 || $# > 2 )); then
    echo "Numero incorrecto de argumentos."
    echo "Agrega el flag -h o --help para mostrar ayuda con el script."
    exit
fi

filepath="$1"

if (( $# == 1 )); then
    outpath="out.ps"
else
    outpath="$2"
fi

echo "Ruta del archivo a imprimir: $filepath"
echo -e "Ruta del archivo de salida: $outpath\n"

not_valid=true

while [[ "$not_valid" = true ]]; do

    echo "¿Donde deseas imprimir?"
    echo "1) Salita"
    echo "2) Toqui"
    echo "X) Cerrar Programa"

    echo -n "Tu respuesta: "

    read -r donde

    case "$donde" in
        1)
            not_valid=false
            echo ""
            ;;
        2)
            not_valid=false
            echo ""
            ;;
        X | x)
            echo "Cerrando el programa..."
            exit
            ;;
        *)
            echo -e "Por favor ingresa una opción válida\n"
            ;;
    esac

done

not_valid=true

while [[ "$not_valid" = true ]]; do

    echo "¿Cara Simple o Doble?"
    echo "1) Simple"
    echo "2) Doble"
    echo "X) Cerrar Programa"

    echo -n "Tu respuesta: "

    read -r cara

    case "$cara" in
        1)
            not_valid=false
            echo ""
            ;;
        2)
            not_valid=false
            echo ""
            ;;
        X | x)
            echo "Cerrando el programa..."
            exit
            ;;
        *)
            echo -e "Por favor ingresa una opción válida\n"
            ;;
    esac

done

if (( $cara == "2" )); then

    not_valid=true

    while [[ "$not_valid" = true ]]; do

        echo "¿Borde Largo o Corto?"
        echo "1) Largo"
        echo "2) Corto"
        echo "X) Cerrar Programa"

        echo -n "Tu respuesta: "

        read -r borde

        case "$borde" in
            1)
                not_valid=false
                echo ""
                ;;
            2)
                not_valid=false
                echo ""
                ;;
            X | x)
                echo "Cerrando el programa..."
                exit
                ;;
            *)
                echo -e "Por favor ingresa una opción válida\n"
                ;;
        esac

    done

fi


case "$donde" in
    1) # Salita
        case "$cara" in
            1) # Simple
                comando="pdf2ps $filepath $outpath && lpr -P hp-335 $outpath"
                resultado="en la Salita en Cara Simple"
                ;;
            2) # Doble
                case "$borde" in
                    1) # Largo
                        comando="pdf2ps $filepath $outpath && duplex $outpath|lpr -P hp-335 "
                        resultado="en la Salita en Doble Cara por el Borde Largo"
                        ;;
                    2) # Corto
                        comando="pdf2ps $filepath $outpath && duplex -l $outpath|lpr -P hp-335 "
                        resultado="en la Salita en Doble Cara por el Borde Corto"
                        ;;
                esac
                ;;
        esac
        ;;
    2) # Toqui
        case "$cara" in
            1) # Simple
                comando="pdf2ps $filepath $outpath && lpr $outpath"
                resultado="en Toqui en Cara Simple"
                ;;
            2) # Doble
                case "$borde" in
                    1) # Largo
                        comando="pdf2ps $filepath $outpath && duplex $outpath|lpr"
                        resultado="en el Toqui en Doble Cara por el Borde Largo"
                        ;;
                    2) # Corto
                        comando="pdf2ps $filepath $outpath && duplex -l $outpath|lpr"
                        resultado="en el Toqui en Doble Cara por el Borde Corto"
                        ;;
                esac
                ;;
        esac
        ;;
esac

echo "Se ejectura el comando: $comando"
echo -e "Es decir que la impresion se realizara: $resultado\n"


not_valid=true

while [[ "$not_valid" = true ]]; do

    echo "¿Deseas continuar con la impresion?"
    echo "1) Si (Se ejecutara el comando)"
    echo "2) No (Se cerrara el programa)"

    echo -n "Tu respuesta: "

    read -r confirmacion

    case "$confirmacion" in
        1)
            not_valid=false
            echo "Ejecutando el comando..."
            eval $comando
            ;;
        2)
            not_valid=false
            echo "Cerrando el programa..."
            exit
            ;;
        *)
            echo -e "Por favor ingresa una opción válida\n"
            ;;
    esac

done

exit