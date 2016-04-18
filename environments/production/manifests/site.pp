#hiera_include('classes')

# All we need to include is the role, which has the same name as stype parameter gotten from ENC
# Maybe stype should be renamed to role?
include "role::${::stype}"
