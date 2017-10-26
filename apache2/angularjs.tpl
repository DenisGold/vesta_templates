<VirtualHost %ip%:%web_port%>

    ServerName %domain_idn%
    %alias_string%
    ServerAdmin %email%
    DocumentRoot %docroot%
    ScriptAlias /cgi-bin/ %home%/%user%/web/%domain%/cgi-bin/
    Alias /vstats/ %home%/%user%/web/%domain%/stats/
    Alias /error/ %home%/%user%/web/%domain%/document_errors/
    #SuexecUserGroup %user% %group%
    CustomLog /var/log/%web_system%/domains/%domain%.bytes bytes
    CustomLog /var/log/%web_system%/domains/%domain%.log combined
    ErrorLog /var/log/%web_system%/domains/%domain%.error.log
    <Directory %docroot%>
        RewriteEngine On
        Options FollowSymLinks
        RewriteBase /
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteCond %{REQUEST_FILENAME} !-d
        RewriteRule ^(.*)$ /#/$1 [L]

        AllowOverride All
        #Options +Includes -Indexes +ExecCGI +FollowSymLinks
        php_admin_value open_basedir none
        php_admin_value upload_tmp_dir /home/admin/tmp
        php_admin_value session.save_path /home/admin/tmp
    </Directory>
    <Directory %home%/%user%/web/%domain%/stats>
        AllowOverride All
    </Directory>

    <IfModule mod_ruid2.c>
        RMode config
        RUidGid %user% %group%
        RGroups www-data
    </IfModule>
    <IfModule itk.c>
        AssignUserID %user% %group%
    </IfModule>

    IncludeOptional %home%/%user%/conf/web/%web_system%.%domain%.conf*

</VirtualHost>
