# ----------------------------------------------------------------------------
#  Copyright 2005-2015 WSO2, Inc. http://www.wso2.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# ----------------------------------------------------------------------------
#
# Class idp::params
#
# This class manages appm idp parameters
#

class idp::params {

  $local_package_dir    = '/mnt/packs'
  $admin_username       = 'ADMIN_USER'
  $admin_password       = 'ADMIN_PASSWORD'

  # app-manager.xml 
  $thirif_server_host         = '192.168.57.132'
  $enable_thrift_server       = true

  # carbon.xml 
  $thrift_receive_port        = 10505
  
  #Cluster configuration details
  $host_name            = 'elb-km.appm.wso2.com'
  $mgt_host_name        = 'elb-km.appm.wso2.com'
  $store_host_name      = 'mgt.store.appm.wso2.com'
  $store_nhttp_port     = '9443'
  $publisher_host_name  = 'publisher.appm.wso2.com'
  $publisher_nhttp_port = '9443'

  # Database details
  $is_mysql_connector	= true
  $mysql_connector_name = 'mysql-connector-java-5.1.23-bin.jar'
  $is_mysql_carbon_db   = true
  $is_h2_carbon_db      = false
  $is_mysql_am_db  	= true
  $is_h2_am_db   	= false
  $is_mysql_stat_db	= false
  $is_h2_stat_db	= true
  $is_mysql_um_db = true
  $is_h2_um_db  = false
  $is_mysql_reg_db = true
  $is_h2_reg_db  = false

  $jndi_datasource_for_carbon_db= 'jdbc/WSO2CarbonDB'
  $jndi_datasource_for_am_db	= 'jdbc/WSO2AM_DB'
  $jndi_datasource_for_stat_db	= 'jdbc/WSO2AM_STATS_DB'
  $jndi_datasource_for_reg_db  = 'jdbc/WSO2REG_DB'
  $jndi_datasource_for_um_db  = 'jdbc/WSO2UM_DB'

  # MySQL server configuration details
  $mysql_server         = '192.168.57.144'
  $mysql_port           = '3306'
  $max_connections      = '100000'
  $max_active           = '50'
  $max_wait             = '60000'
  $mysql_database_name_for_carbon_db	= 'WSO2_CARBON_DB'
  $mysql_username	= 'user'
  $mysql_password	= 'password'
  $mysql_database_name_for_am_db	= 'WSO2_AM_DB'
  $mysql_database_name_for_stat_db	= 'WSO2AM_STATS_DB'
  $mysql_database_name_for_um_db  = 'MYSQL_UM_DB'
  $mysql_database_name_for_reg_db  = 'WSO2_REG_DB'

  # H2 server configuration details
  $h2_db_path_for_am_db		= 'repository/database'
  $h2_db_path_for_carbon_db	= 'repository/database'
  $h2_db_path_for_stat_db	= 'repository/database'
  $h2_database_name_for_carbon_db	= 'WSO2CARBON_DB'
  $h2_username		= 'wso2carbon'
  $h2_password		= 'wso2carbon'
  $h2_database_name_for_am_db		= 'WSO2AM_DB'
  $h2_database_name_for_stat_db		= 'WSO2AM_STATS_DB'

  # Registry configuration details
  $remote_instance_govregistry = '"https://mgt.publisher.appm.wso2.com:9543/registry"'
  $remote_instance_configregistry = '"https://mgt.publisher.appm.wso2.com:9643/registry"'
  $remote_instance_gov_cacheid = 'user@jdbc:mysql://192.168.57.144:3306/WSO2_REG_DB'
  $remote_instance_config_cacheid = 'user@jdbc:mysql://192.168.57.144:3306/WSO2_REG_DB'

  # AppM statictics configration details
  $is_ui_activity_bam_publish	= false
  $is_appm_usage_tracker	= false
  $bam_thrift_port		= '7611'
  $bam_server_url		= 'tcp://10.10.10.6:7611/'
  $bam_username			= 'admin'
  $bam_password			= 'admin'

  $registry_user        = 'DB_USER'
  $registry_password    = 'DB_PASSWORD'
  $registry_database    = 'REGISTRY_DB'

  $userstore_user       = 'DB_USER'
  $userstore_password   = 'DB_PASSWORD'
  $userstore_database   = 'USERSTORE_DB'

  #LDAP settings - not used
  $ldap_connection_uri      = 'ldap://localhost:10389'
  $bind_dn                  = 'uid=admin,ou=system'
  $bind_dn_password         = 'adminpassword'
  $user_search_base         = 'ou=system'
  $group_search_base        = 'ou=system'
  $sharedgroup_search_base  = 'ou=SharedGroups,dc=wso2,dc=org'

  #Proxy ports
  $http_proxy_port             = '80'
  $https_proxy_port             = '443'

  #host mapping 
  $idp_node_ip                      = '192.168.57.132'
  $idp_node_host_name               = 'elb-km.appm.wso2.com'
  $publisher_worker_node_id         = '192.168.57.134'
  $publisher_worker_node_host_name  = 'publisher.appm.wso2.com'
  $publisher_mgt_node_id            = '192.168.57.134'
  $publisher_mgt_node_host_name     = 'mgt.publisher.appm.wso2.com'
  $store_worker_node_id             = '192.168.57.135'
  $store_worker_node_host_name      = 'worker.store.appm.wso2.com'
  $store_mgt_node_ip                = '192.168.57.135'
  $store_mgt_node_host_name         = 'mgt.store.appm.wso2.com'
  $store_node_ip                    = '192.168.57.135'
  $store_node_host_name             = 'store.appm.wso2.com'
  $load_balancer_node_ip            = '192.168.57.135'
  $load_balancer_node_host_name     = 'elb.appm.wso2.com'
  $gateway_mgt_node_ip              = '192.168.57.136'
  $gateway_mgt_node_host_name       = 'gateway.mgt.wso2.com'
  $gateway_worker_node_ip           = '192.168.57.139'
  $gateway_worker_node_host_name    = 'gateway.wkr.wso2.com'
  $mysql_server_node_ip             = '192.168.57.144'
  $mysql_server_node_host_name      = 'mysql-puppet.appm.wso2.com'
  $puppet_master_node_ip            = '192.168.57.144'
  $puppet_master_node_host_name     = 'mysql-puppet.appm.wso2.com'
}
