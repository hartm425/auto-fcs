/home/tsaim/lane0212/R/3.3.4

/panfs/roc/msisoft/R/3.4.0/

FILES='/home/thyagara/shared/HRS/UPLOAD\ FCS\ HRS\ samples/'
for f in $FILES
do
	echo "Processing $f"
done

 cp -vr /home/thyagara/shared/HRS/UPLOAD\ FCS\ HRS\ samples/ -t ./fcs/
 
 
 find . -type f -name '*.fcs' -exec cp -t /scratch.global/lanej/flow/full/fcs {} \;
