#!/bin/bash

sleep 2
var=$(pwd)
sleep 1
echo "A INSTALAÇÃO ESTÁ TERMINANDO!"
echo "NÓS ESTAMOS TRABALHANDO NO DIRETÓRIO: $var."
echo "VOCÊ GOSTARIA DE INSTALAR AS SEGUINTES EXTENSÕES DO GNOME-SHELL:"
echo ""
ls -l $var/extencoes_gnome42

sleep 1
echo "INSTALAR AGORA?[S/N]: "
read resposta
if [ $resposta == "S" -o $resposta == "s" ] ; then
bash ./install_extensions.sh
echo "PRONTO!! AS EXTENSÕES FORAM DESCOMPACTADAS E PODERÃO SER ATIVADAS APÓS A REINICIALIZAÇÃO DO SISTEMA."
echo "O COMANDO PARA A ATIVAÇÃO É 'gnome-extensions enable UUID', em que o UUID É O IDENTIFICADOR UNIVERSAL ÚNICO DA EXTENÇÃO."
else sleep 1
echo "OK. VOCÊ PODE INSTALá-LAS MAIS TARDE A PARTIR DA LISTA DE EXTENSÕES CRIADA NA SUA PASTA PESSOAL (home)."
bash ./write_ext_list_PopOS.sh
fi