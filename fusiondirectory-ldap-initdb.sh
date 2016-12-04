#!/bin/bash

/usr/sbin/fusiondirectory-insert-schema -e /etc/ldap/schema/nis.schema -y
SCHEMAS_TO_LOAD=$(ls /etc/ldap/schema/fusiondirectory/*.schema)
while [ -n "$SCHEMAS_TO_LOAD" ]; do
    SCHEMAS_TO_TRY=$SCHEMAS_TO_LOAD
    SCHEMAS_TO_LOAD=""
    for SCHEMA in $SCHEMAS_TO_TRY; do
        /usr/sbin/fusiondirectory-insert-schema -i $SCHEMA || SCHEMAS_TO_LOAD="$SCHEMAS_TO_LOAD $SCHEMA"
    done
done

ldapadd -D cn=admin,dc=ldap,dc=dit -y /etc/ldap/ldap.passwd <<EOF
dn: dc=ldap,dc=dit
dc: ldap
ou: ldap
description: ldap
objectClass: top
objectClass: dcObject
objectClass: locality
objectClass: gosaDepartment
objectclass: gosaAcl
gosaAclEntry: 0:subtree:$(echo -n "cn=admin,ou=aclroles,dc=ldap,dc=dit" | base64):$(echo -n "uid=fd-admin,ou=people,dc=ldap,dc=dit" | base64)

dn: ou=configs,dc=ldap,dc=dit
ou: configs
objectClass: organizationalUnit

dn: ou=snapshots,dc=ldap,dc=dit
ou: snapshots
objectClass: organizationalUnit

dn: ou=people,dc=ldap,dc=dit
ou: people
objectClass: organizationalUnit

dn: ou=groups,dc=ldap,dc=dit
ou: groups
objectClass: organizationalUnit

dn: ou=systems,dc=ldap,dc=dit
ou: systems
objectClass: organizationalUnit

dn: ou=configs,ou=systems,dc=ldap,dc=dit
objectClass: organizationalUnit
ou: configs

dn: ou=fusiondirectory,ou=configs,ou=systems,dc=ldap,dc=dit
ou: fusiondirectory
objectClass: organizationalUnit

dn: ou=aclroles,dc=ldap,dc=dit
ou: aclroles
objectClass: organizationalUnit

dn: cn=fusiondirectory,ou=configs,dc=ldap,dc=dit
fdPasswordDefaultHash: ssha
fdUserRDN: ou=people
fdGroupRDN: ou=groups
fdAclRoleRDN: ou=aclroles
fdGidNumberBase: 1100
fdUidNumberBase: 1100
fdAccountPrimaryAttribute: uid
fdLoginAttribute: uid
fdTimezone: Europe/London
fdRfc2307bis: TRUE
fdStrictNamingRules: TRUE
fdHandleExpiredAccounts: FALSE
fdEnableSnapshots: TRUE
fdSnapshotBase: ou=snapshots,dc=ldap,dc=dit
fdLanguage: en_US
fdTheme: default
fdPrimaryGroupFilter: FALSE
fdModificationDetectionAttribute: entryCSN
fdCopyPaste: TRUE
fdListSummary: TRUE
fdLdapStats: FALSE
fdWarnSSL: TRUE
fdForceSSL: FALSE
fdSchemaCheck: TRUE
fdLogging: TRUE
fdDisplayErrors: FALSE
fdSessionLifeTime: 1800
fdDebugLevel: 0
cn: fusiondirectory
fusionConfigMd5: a2d84b4bc24dfe28e21f6576ae097d9b
fdForcePasswordDefaultHash: FALSE
fdLdapSizeLimit: 200
fdDisplayHookOutput: FALSE
fdShells: /bin/ash
fdShells: /bin/bash
fdShells: /bin/csh
fdShells: /bin/sh
fdShells: /bin/ksh
fdShells: /bin/tcsh
fdShells: /bin/dash
fdShells: /bin/zsh
fdShells: /sbin/nologin
fdShells: /bin/false
fdAclTabOnObjects: FALSE
fdMinId: 100
fdIdAllocationMethod: traditional
fdSambaMachineAccountRDN: ou=computers,ou=systems
fdSambaIdMapping: FALSE
fdSambaSID: 0-815-4711
fdSambaRidBase: 1
fdSambaGenLMPassword: FALSE
fdMailAttribute: mail
fdCyrusUseSlashes: FALSE
fdCyrusDeleteMailbox: FALSE
fdPpolicyRDN: ou=ppolicies
fdPpolicyDefaultCn: default
fdOpsiRDN: ou=opsi
fdOGroupRDN: ou=groups
fdForceSaslPasswordAsk: FALSE
fdLconfPrefix: lconf
fdDSARDN: ou=dsa
fdAliasRDN: ou=alias
fdRepositoryRDN: ou=repository
fdRepositoryTypes: debian
fdNetgroupRDN: ou=netgroups
fdDashboardNumberOfDigit: 3
fdDashboardPrefix: PC
fdDashboardExpiredAccountsDays: 15
fdApplicationsRDN: ou=apps
fdWebappsRDN: ou=apps
fdWebappsMenu: none
fdDNSFinalDot: TRUE
fdSogoRDN: ou=resources
fdInventoryRDN: ou=inventory
fdInventoryMatching: mac
fdWebserviceForceSSL: TRUE
fdSudoRDN: ou=sudoers
fdFaiBaseRDN: ou=fai,ou=configs,ou=systems
fdFaiScriptRDN: ou=scripts
fdFaiHookRDN: ou=hooks
fdFaiTemplateRDN: ou=templates
fdFaiVariableRDN: ou=variables
fdFaiProfileRDN: ou=profiles
fdFaiPackageRDN: ou=packages
fdFaiPartitionRDN: ou=disk
objectClass: fusionDirectoryConf
objectClass: fdSambaPluginConf
objectClass: fdMailPluginConf
objectClass: fdPpolicyPluginConf
objectClass: fdOpsiPluginConf
objectClass: fusionDirectoryPluginsConf
objectClass: fdNagiosPluginConf
objectClass: fdDsaPluginConf
objectClass: fdAliasPluginConf
objectClass: fdRepositoryPluginConf
objectClass: fdNetgroupPluginConf
objectClass: fdDashboardPluginConf
objectClass: fdApplicationsPluginConf
objectClass: fdDnsPluginConf
objectClass: fdSogoPluginConf
objectClass: fdInventoryPluginConf
objectClass: fdWebservicePluginConf
objectClass: fdSudoPluginConf
objectClass: fdFaiPluginConf
objectClass: fdSystemsPluginConf
fdSystemRDN: ou=systems
fdServerRDN: ou=servers,ou=systems
fdWorkstationRDN: ou=workstations,ou=systems
fdTerminalRDN: ou=terminals,ou=systems
fdPrinterRDN: ou=printers,ou=systems
fdComponentRDN: ou=netdevices,ou=systems
fdMobilePhoneRDN: ou=mobile,ou=systems
fdEncodings: UTF-8=UTF-8
fdEncodings: ISO8859-1=ISO8859-1 (Latin 1)
fdEncodings: ISO8859-2=ISO8859-2 (Latin 2)
fdEncodings: ISO8859-3=ISO8859-3 (Latin 3)
fdEncodings: ISO8859-4=ISO8859-4 (Latin 4)
fdEncodings: ISO8859-5=ISO8859-5 (Latin 5)
fdEncodings: cp850=CP850 (Europe)

dn: uid=fd-admin,ou=people,dc=ldap,dc=dit
objectClass: top
objectClass: person
objectClass: gosaAccount
objectClass: organizationalPerson
objectClass: inetOrgPerson
givenName: System
sn: Administrator
cn: System Administrator-fd-admin
uid: fd-admin
userPassword: $(slappasswd -s "fusion")

dn: cn=admin,ou=aclroles,dc=ldap,dc=dit
cn: admin
description: Give all rights on all objects
objectClass: top
objectClass: gosaRole
gosaAclTemplate: 0:all;cmdrw

dn: cn=manager,ou=aclroles,dc=ldap,dc=dit
cn: manager
description: Give all rights on users in the given branch
objectClass: top
objectClass: gosaRole
gosaAclTemplate: 0:user/password;cmdrw,user/user;cmdrw,user/posixAccount;cmdrw

dn: cn=editowninfos,ou=aclroles,dc=ldap,dc=dit
cn: editowninfos
description: Allow users to edit their own information (main tab and posix use
  only on base)
objectClass: top
objectClass: gosaRole
gosaAclTemplate: 0:user/posixAccount;srw,user/user;srw
EOF

cat > /etc/fusiondirectory/fusiondirectory.conf <<EOF
<?xml version="1.0"?>
<conf>

  <!-- Services **************************************************************
    Old services that are not based on simpleService needs to be listed here
   -->
  <serverservice>
    <tab class="serviceDHCP"        />
    <tab class="serviceDNS"         />
  </serverservice>

  <!-- Main section **********************************************************
       The main section defines global settings, which might be overridden by
       each location definition inside.

       For more information about the configuration parameters, take a look at
       the FusionDirectory.conf(5) manual page.
  -->
  <main default="default"
        logging="TRUE"
        displayErrors="FALSE"
        forceSSL="FALSE"
        templateCompileDirectory="/var/spool/fusiondirectory/"
        debugLevel="0"
    >

    <!-- Location definition -->
    <location name="default"
        config="ou=fusiondirectory,ou=configs,ou=systems,dc=ldap,dc=dit">

        <referral URI="ldap://localhost/dc=ldap,dc=dit"
                        adminDn="cn=admin,dc=ldap,dc=dit"
                        adminPassword="$(cat /etc/ldap/ldap.passwd)" />
    </location>
  </main>
</conf>
EOF
chown root:www-data /etc/fusiondirectory/fusiondirectory.conf
chmod 0640 /etc/fusiondirectory/fusiondirectory.conf
