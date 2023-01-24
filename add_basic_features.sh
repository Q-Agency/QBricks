echo "Do you want to add flutter storage? (y/n)"
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then
  mason make local_storage
fi

echo "Do you want to add connectivity? (y/n)"
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then
  mason make connectivity
fi