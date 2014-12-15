<?php
$conf['authtype']                               = 'authad';
$conf['plugin']['authad']['account_suffix']     = '@domain';
$conf['plugin']['authad']['base_dn']            = 'ou=base,dc=dn';
$conf['plugin']['authad']['domain_controllers'] = 'dc1.domain';

$conf['plugin']['authad']['use_ssl']            = 1;
$conf['plugin']['authad']['real_primarygroup']  = 1;
$conf['plugin']['authad']['recursive_groups']   = 1;
$conf['plugin']['authad']['debug']              = 0;
