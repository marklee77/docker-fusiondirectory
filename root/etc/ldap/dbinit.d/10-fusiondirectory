#!/bin/bash

: ${fusiondirectory_ldap_uri:=ldap://localhost}
: ${fusiondirectory_ldap_tls:=TRUE}

: ${fusiondirectory_timezone:=Europe/London}
: ${fusiondirectory_language:=en_US}
: ${fusiondirectory_admin_password:=$(pwgen -s1 32)}

# set secure umask
umask 0227

/usr/sbin/fusiondirectory-insert-schema -e /etc/ldap/schema/nis.schema -y
SCHEMAS_TO_LOAD=$(ls /etc/ldap/schema/fusiondirectory/*.schema)
while [ -n "$SCHEMAS_TO_LOAD" ]; do
    SCHEMAS_TO_TRY=$SCHEMAS_TO_LOAD
    SCHEMAS_TO_LOAD=""
    for SCHEMA in $SCHEMAS_TO_TRY; do
        /usr/sbin/fusiondirectory-insert-schema -i $SCHEMA || SCHEMAS_TO_LOAD="$SCHEMAS_TO_LOAD $SCHEMA"
    done
done

ldapadd -f /etc/ldap/schema/ppolicy.ldif

ldapadd <<EOF
dn: cn=module,cn=config
cn: module
objectClass: olcModuleList
olcModuleLoad: ppolicy.la

dn: olcOverlay=ppolicy,olcDatabase={1}mdb,cn=config
objectClass: olcOverlayConfig
objectClass: olcPPolicyConfig
olcOverlay: ppolicy
olcPPolicyDefault: cn=default,ou=ppolicies,$slapd_basedn
olcPPolicyHashCleartext: FALSE
olcPPolicyUseLockout: FALSE
olcPPolicyForwardUpdates: FALSE
EOF

ldapadd -D cn=admin,$slapd_basedn -y /etc/ldap/ldap.passwd <<EOF
dn: $slapd_basedn
dc: ldap
o: ldap
ou: ldap
description: ldap
objectClass: top
objectClass: dcObject
objectClass: organization
objectClass: gosaDepartment
objectclass: gosaAcl
gosaAclEntry: 0:subtree:$(echo -n "cn=admin,ou=aclroles,$slapd_basedn" | base64):$(echo -n "uid=admin,ou=people,$slapd_basedn" | base64)
gosaAclEntry: 1:base:$(echo -n "cn=editownpwd,ou=aclroles,$slapd_basedn" | base64):$(echo -n "*" | base64)

dn: ou=fusiondirectory,$slapd_basedn
objectClass: organizationalUnit
ou: fusiondirectory

dn: cn=config,ou=fusiondirectory,$slapd_basedn
cn: config
fdLanguage: $fusiondirectory_language
fdTheme: breezy
fdTimezone: $fusiondirectory_timezone
fdSchemaCheck: TRUE
fdPasswordDefaultHash: ssha
fdListSummary: TRUE
fdModificationDetectionAttribute: entryCSN
fdLogging: TRUE
fdLdapSizeLimit: 200
fdLoginAttribute: uid
fdWarnSSL: FALSE
fdSessionLifeTime: 1800
fdHttpHeaderAuthHeaderName: AUTH_USER
fdEnableSnapshots: TRUE
fdSnapshotBase: ou=snapshots,$slapd_basedn
fdSslKeyPath: /etc/ssl/private/fd.key
fdSslCertPath: /etc/ssl/certs/fd.cert
fdSslCaCertPath: /etc/ssl/certs/ca.cert
fdCasServerCaCertPath: /etc/ssl/certs/ca.cert
fdCasHost: localhost
fdCasPort: 443
fdCasContext: /cas
fdAccountPrimaryAttribute: uid
fdCnPattern: %givenName% %sn%
fdStrictNamingRules: TRUE
fdMinId: 100
fdUidNumberBase: 2000
fdGidNumberBase: 2000
fdUserRDN: ou=people
fdGroupRDN: ou=groups
fdAclRoleRDN: ou=aclroles
fdIdAllocationMethod: traditional
fdDebugLevel: 0
fdShells: /bin/bash
fdShells: /bin/csh
fdShells: /bin/sh
fdShells: /bin/ksh
fdShells: /bin/tcsh
fdShells: /bin/zsh
fdShells: /sbin/nologin
fdShells: /bin/false
fdShells: /usr/bin/git-shell
fdForcePasswordDefaultHash: FALSE
fdHandleExpiredAccounts: FALSE
fdForceSSL: FALSE
fdHttpAuthActivated: FALSE
fdHttpHeaderAuthActivated: FALSE
fdCasActivated: FALSE
fdRestrictRoleMembers: FALSE
fdDisplayErrors: FALSE
fdLdapStats: FALSE
fdDisplayHookOutput: FALSE
fdAclTabOnObjects: FALSE
fdSambaMachineAccountRDN: ou=computers,ou=systems
fdSambaIdMapping: FALSE
fdSambaSID: 0-815-4711
fdSambaRidBase: 1
fdSambaGenLMPassword: FALSE
fdSambaPrimaryGroupWarning: FALSE
fdMailAttribute: mail
fdCyrusUseSlashes: FALSE
fdCyrusDeleteMailbox: FALSE
fdPpolicyRDN: ou=ppolicies
fdPpolicyDefaultCn: default
fdDnsRDN: ou=dns
fdDNSFinalDot: TRUE
fdLconfPrefix: lconf
fdWebserviceForceSSL: TRUE
fdAliasRDN: ou=alias
fdOGroupRDN: ou=groups
fdForceSaslPasswordAsk: FALSE
fdInventoryRDN: ou=inventory
fdInventoryMatching: mac
fdDSARDN: ou=dsa
fdSudoRDN: ou=sudoers
fdSupannStructuresRDN: ou=structures
fdSupannPasswordRecovery: TRUE
fdDashboardNumberOfDigit: 3
fdDashboardPrefix: PC
fdDashboardExpiredAccountsDays: 15
fdAuditRDN: ou=audit
fdAuditActions: modify
fdAuditActions: create
fdAuditActions: remove
fdAuditRotationDelay: 120
fdAutofsRDN: ou=autofs
fdApplicationsRDN: ou=apps
fdWebappsRDN: ou=apps
fdWebappsMenu: none
fdOpsiRDN: ou=opsi
fdEjbcaRDN: ou=certificates
fdRepositoryRDN: ou=repository
fdRepositoryTypes: debian
fdDhcpRDN: ou=dhcp
fdPrivateEmailPasswordRecovery: FALSE
fdSogoRDN: ou=resources
fdNetgroupRDN: ou=netgroups
fdUserReminderAlertDelay: 15
fdUserReminderResendDelay: 7
fdUserReminderPostponeDays: 15
fdUserReminderEmail: to.be@chang.ed
fdUserReminderForwardAlert: TRUE
fdUserReminderAlertSubject: [FusionDirectory] Your account is about to expire
fdUserReminderAlertBody:: RGVhciAlMSRzLAp5b3VyIGFjY291bnQgJTIkcyBpcyBhYm91dCB0
 byBleHBpcmUsIHBsZWFzZSB1c2UgdGhpcyBsaW5rIHRvIGF2b2lkIHRoaXM6IApodHRwczovL2xvY
 2FsaG9zdC9mdXNpb25kaXJlY3Rvcnkvc2V0dXAucGhwL2V4cGlyZWRfcG9zdHBvbmUucGhwP3VpZD
 0lMiRzJnRva2VuPSUzJHMK
fdUserReminderForwardConfirmation: TRUE
fdUserReminderConfirmationSubject: [FusionDirectory] Your account expiration h
 as been postponed
fdUserReminderConfirmationBody:: RGVhciAlMSRzLAogeW91ciBhY2NvdW50ICUyJHMgZXhwa
 XJhdGlvbiBoYXMgYmVlbiBzdWNjZXNzZnVsbHkgcG9zdHBvbmVkLgo=
fdFaiBaseRDN: ou=fai,ou=configs,ou=systems
fdFaiScriptRDN: ou=scripts
fdFaiHookRDN: ou=hooks
fdFaiTemplateRDN: ou=templates
fdFaiVariableRDN: ou=variables
fdFaiProfileRDN: ou=profiles
fdFaiPackageRDN: ou=packages
fdFaiPartitionTableRDN: ou=disk
fdSystemRDN: ou=systems
fdServerRDN: ou=servers,ou=systems
fdWorkstationRDN: ou=workstations,ou=systems
fdTerminalRDN: ou=terminals,ou=systems
fdPrinterRDN: ou=printers,ou=systems
fdComponentRDN: ou=netdevices,ou=systems
fdPhoneRDN: ou=phones,ou=systems
fdMobilePhoneRDN: ou=mobile,ou=systems
fdEncodings: UTF-8=UTF-8
fdEncodings: ISO8859-1=ISO8859-1 (Latin 1)
fdEncodings: ISO8859-2=ISO8859-2 (Latin 2)
fdEncodings: ISO8859-3=ISO8859-3 (Latin 3)
fdEncodings: ISO8859-4=ISO8859-4 (Latin 4)
fdEncodings: ISO8859-5=ISO8859-5 (Latin 5)
fdEncodings: cp850=CP850 (Europe)
objectClass: fusionDirectoryConf
objectClass: fdSambaPluginConf
objectClass: fdMailPluginConf
objectClass: fdPpolicyPluginConf
objectClass: fdDnsPluginConf
objectClass: fdNagiosPluginConf
objectClass: fdWebservicePluginConf
objectClass: fdCommunityPluginConf
objectClass: fdAliasPluginConf
objectClass: fusionDirectoryPluginsConf
objectClass: fdInventoryPluginConf
objectClass: fdDsaPluginConf
objectClass: fdSudoPluginConf
objectClass: fdSupannPluginConf
objectClass: fdNewsletterPluginConf
objectClass: fdDashboardPluginConf
objectClass: fdAuditPluginConf
objectClass: fdAutofsPluginConf
objectClass: fdApplicationsPluginConf
objectClass: fdOpsiPluginConf
objectClass: fdEjbcaPluginConf
objectClass: fdRepositoryPluginConf
objectClass: fdDhcpPluginConf
objectClass: fdPersonalPluginConf
objectClass: fdSogoPluginConf
objectClass: fdNetgroupPluginConf
objectClass: fdUserReminderPluginConf
objectClass: fdFaiPluginConf
objectClass: fdSystemsPluginConf
objectClass: fdPasswordRecoveryConf
fdPasswordRecoveryActivated: FALSE
fdPasswordRecoveryEmail: to.be@chang.ed
fdPasswordRecoveryValidity: 10
fdPasswordRecoverySalt: SomethingSecretAndVeryLong
fdPasswordRecoveryUseAlternate: FALSE
fdPasswordRecoveryMailSubject: [FusionDirectory] Password recovery link
fdPasswordRecoveryMailBody:: SGVsbG8sCgpIZXJlIGFyZSB5b3VyIGluZm9ybWF0aW9ucyA6I
 AogLSBMb2dpbiA6ICVzCiAtIExpbmsgOiAlcwoKVGhpcyBsaW5rIGlzIG9ubHkgdmFsaWQgZm9yID
 EwIG1pbnV0ZXMu
fdPasswordRecoveryMail2Subject: [FusionDirectory] Password recovery successful
fdPasswordRecoveryMail2Body:: SGVsbG8sCgpZb3VyIHBhc3N3b3JkIGhhcyBiZWVuIGNoYW5n
 ZWQuCllvdXIgbG9naW4gaXMgc3RpbGwgJXMu

dn: ou=aclroles,$slapd_basedn
objectClass: organizationalUnit
ou: aclroles

dn: cn=admin,ou=aclroles,$slapd_basedn
objectClass: top
objectClass: gosaRole
cn: admin
description: Gives all rights on all objects
gosaAclTemplate: 0:all;cmdrw

dn: cn=manager,ou=aclroles,$slapd_basedn
cn: manager
description: Give all rights on users in the given branch
objectClass: top
objectClass: gosaRole
gosaAclTemplate: 0:user/user;cmdrw,user/posixAccount;cmdrw

dn: cn=editowninfos,ou=aclroles,$slapd_basedn
cn: editowninfos
description: Allow users to edit their own information (main tab and posix use
  only on base)
objectClass: top
objectClass: gosaRole
gosaAclTemplate: 0:user/user;srw,user/posixAccount;srw

dn: cn=editownpwd,ou=aclroles,$slapd_basedn
cn: editownpwd
description: Allow users to edit their own password (use only on base)
objectClass: top
objectClass: gosaRole
gosaAclTemplate: 0:user/user;s#userPassword;rw

dn: ou=people,$slapd_basedn
objectClass: organizationalUnit
ou: people

dn: uid=admin,ou=people,$slapd_basedn
cn: System Administrator
sn: Administrator
givenName: System
uid: admin
objectClass: inetOrgPerson
objectClass: organizationalPerson
objectClass: person
userPassword: $(slappasswd -s "$fusiondirectory_admin_password")

dn: ou=ppolicies,$slapd_basedn
objectClass: organizationalUnit
ou: ppolicies

dn: cn=default,ou=ppolicies,$slapd_basedn
objectClass: device
objectClass: pwdPolicy
objectClass: pwdPolicyChecker
pwdAttribute: userPassword
cn: default
pwdAllowUserChange: TRUE
pwdCheckQuality: 0
pwdLockout: TRUE
pwdSafeModify: FALSE
pwdMustChange: FALSE

dn: ou=alias,$slapd_basedn
objectClass: organizationalUnit
ou: alias
EOF

cat > /etc/fusiondirectory/fusiondirectory.conf <<EOF
<?xml version="1.0"?>
<conf>
  <main default="default"
        logging="TRUE"
        displayErrors="FALSE"
        forceSSL="FALSE"
        templateCompileDirectory="/var/spool/fusiondirectory/"
        debugLevel="0"
    >
    <location name="default" ldapTLS="$fusiondirectory_ldap_tls">
        <referral URI="$fusiondirectory_ldap_uri/$slapd_basedn"
                  adminDn="cn=admin,$slapd_basedn"
                  adminPassword="$slapd_admin_password" />
    </location>
  </main>
</conf>
EOF
chgrp www-data /etc/fusiondirectory/fusiondirectory.conf

echo -n "$fusiondirectory_admin_password" > /etc/fusiondirectory/fusiondirectory.passwd
