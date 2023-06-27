#!/bin/bash
echo "Augusto v0.1 actualizacion..."
echo "/ROOT/.SSH"
USERNAME=root
HOSTS="192.0.2.3 192.0.2.13 192.0.2.21 192.168.1.3 192.0.2.28"
SCRIPT="apt update; apt upgrade -y; apt autoremove -y; apt clean; apt purge"
SCRIPT2="rpi-update -y"
SCRIPTREBOOT="systemctl reboot -i"
CONTINUO=1
RASPBERRYIP=192.168.1.2
USERNAMEPI=pi
actualizartodo(){

        for HOSTNAME in ${HOSTS} ; do
                echo "************************************"
                echo Conectandose a: $HOSTNAME
                echo "************************************"
                ssh -o ConnectTimeout=5 -l ${USERNAME} ${HOSTNAME} "${SCRIPT}"
        done

}

reiniciartodo(){
        echo "Reiniciando todo ... "
        for HOSTNAME in ${HOSTS} ; do
                echo "************************************"
                echo Conectandose a: $HOSTNAME
                echo "************************************"
                ssh -o ConnectTimeout=5 -l ${USERNAME} ${HOSTNAME} "${SCRIPTREBOOT}"
        done

}

actualizarraspberry(){
        echo "************************************"
        echo Conectandose a: $RASPBERRYIP
        echo "************************************"
                ssh -o ConnectTimeout=5 -l ${USERNAMEPI} ${RASPBERRYIP} "${SCRIPT}"

}

actualizaprom(){
        
        echo "OJO! Quieres actualizar la raspberry eROM? Presionar y si es si"
        read respuesta
        echo "********* /n /n "
        if [ $respuesta == "y" ]; then
                echo "Actualizando raspberry pi..."
                ssh -o ConnectTimeout=5 -l ${USERNAMEPI} ${RASPBERRYIP} "${SCRIPT2}"
        else
                echo "me voy chaooo!!!"
        fi

        echo "Gracias!!!"
        
}





while : 
do
        #statements
        echo " 1) Actualizar todo 2) Reiniciar todo 3) Actualizar raspberry paquetes 4) actualizar raspberry erom 5) salir: "
        read OPCIONES
        case $OPCIONES in 
                1)
                        echo "Actualizando todo...:"
                        actualizartodo
                        ;;
                2)
                        echo "Reiniciar todo...:"
                        reiniciartodo
                        ;;

                3)      
                        echo "Actualizando raspberry"
                        actualizarraspberry
                        ;;
                        
                4)
                        echo "Actualizando ROM raspberry"
                        actualizaprom
                        ;;      
                        
                5) 
                echo "Gracias..."
                exit 0
                ;;
                *) 
                echo "Opcion incorrecta"
                ;;
        esac
        echo "****************************** \n"
done
