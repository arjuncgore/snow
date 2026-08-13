#!/bin/bash

mkdir /tmp/mc
for i in {1..4}
do
  mkdir /tmp/mc/$i

  # Importing Practice maps
  ln -s "/home/arjungore/mcsr/worlds/ZZ_Bastion" /tmp/mc/$i
  ln -s "/home/arjungore/mcsr/worlds/ZZ_Blaze" /tmp/mc/$i
  ln -s "/home/arjungore/mcsr/worlds/ZZ_Crafting" /tmp/mc/$i
  ln -s "/home/arjungore/mcsr/worlds/ZZ_Portal" /tmp/mc/$i
  ln -s "/home/arjungore/mcsr/worlds/ZZ_Preemptive" /tmp/mc/$i
  ln -s "/home/arjungore/mcsr/worlds/ZZ_Zero" /tmp/mc/$i
  ln -s "/home/arjungore/mcsr/worlds/ZZ_SearchCrafting" /tmp/mc/$i
  ln -s "/home/arjungore/mcsr/worlds/ZZ_MCSR" /tmp/mc/$i

  chown arjungore -R /tmp/mc/$i
done
