rsync -av ./panel2 /home/thyagara/shared/HRS/annotation/r21/


rsync -rv --exclude '*ASMIC*' --exclude '*PILOT*' --exclude '*PANEL_2*' --exclude '*Specimen*' ./ /home/thyagara/shared/HRS/annotation/r22/panel1/