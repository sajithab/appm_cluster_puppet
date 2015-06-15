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

# IDP node
node /elb-km.appm.wso2.com/ inherits base {

    notify { $name: 
        message => "on elb-km.appm.wso2.com node",
    }

    $docroot = "/mnt/${server_ip}/wso2appm-1.0.0"

    class {'idp':

        version            => '1.0.0',
        sub_cluster_domain => undef,
        members            => undef,
        offset		       => 0,
        hazelcast_port     => undef,
        thrift_receive_port=> 10505,
        config_db          => 'AS_CONFIG_DB',
        config_target_path => 'AS_CONFIG_PATH',
        maintenance_mode   => 'zero',
        depsync            => false,
        clustering         => false,
        cloud		       => false,
        owner              => 'root',
        group              => 'root',
        target             => "/mnt/${server_ip}"
    }
  
    require java  

    Class['java'] -> Class['idp']
}

# publisher mode
node /publisher.appm.wso2.com/ inherits base {

    notify { $name: 
        message => "on publisher.appm.wso2.com node",
    }

    $docroot = "/mnt/${server_ip}/wso2appm-1.0.0"

    class {'publisher':

        version            => '1.0.0',
        sub_cluster_domain => 'mgt',
        members            => {'mgt.store.appm.wso2.com' => '4100'},
        offset             => 0,
        hazelcast_port     => 4000,
        thrift_receive_port=> 10501,
        config_db          => 'AS_CONFIG_DB',
        config_target_path => 'AS_CONFIG_PATH',
        maintenance_mode   => 'zero',
        depsync            => false,
        clustering         => true,
        cloud              => false,
        owner              => 'root',
        group              => 'root',
        target             => "/mnt/${server_ip}"
    }
  
    require java  

    Class['java'] -> Class['publisher']
}

#store managment node
node /store.appm.wso2.com/ inherits base {

    notify { $name: 
        message => "on mgt.store.appm.wso2.com node",
    }

    $docroot = "/mnt/${server_ip}/wso2appm-1.0.0"

    class {'store':

        version            => '1.0.0',
        sub_cluster_domain => 'mgt',
        members            => {'publisher.appm.wso2.com' => '4000', 'worker.store.appm.wso2.com' => '4200'},
        local_member_host  => 'mgt.store.appm.wso2.com',
        offset             => 0,
        hazelcast_port     => 4100,
        thrift_receive_port=> 10500,
        config_db          => 'AS_CONFIG_DB',
        config_target_path => 'AS_CONFIG_PATH',
        maintenance_mode   => 'zero',
        depsync            => false,
        clustering         => true,
        cloud              => false,
        owner              => 'root',
        group              => 'root',
        target             => "/mnt/${server_ip}"
    }
  
    require java  

    Class['java'] -> Class['store']
}

#store worker node and nginx node
node /elb.appm.wso2.com/ inherits base {

    notify { $name: 
        message => "on worker.store.appm.wso2.com node",
    }

    $docroot = "/mnt/${server_ip}/wso2appm-1.0.0"

    class {'store':

        version            => '1.0.0',
        sub_cluster_domain => 'worker',
        members            => {'mgt.store.appm.wso2.com' => '4100'},
        local_member_host  => 'worker.store.appm.wso2.com',
        offset             => 1,
        hazelcast_port     => 4200,
        thrift_receive_port=> 10502,
        config_db          => 'AS_CONFIG_DB',
        config_target_path => 'AS_CONFIG_PATH',
        maintenance_mode   => 'zero',
        depsync            => false,
        clustering         => true,
        cloud              => false,
        owner              => 'root',
        group              => 'root',
        target             => "/mnt/${server_ip}"
    }
  
    require java  

    Class['java'] -> Class['store']
}

# gateway managment node
node /gateway.mgt.wso2.com/ inherits base {

    notify { $name: 
        message => "on gateway.mgt.wso2.com node",
    }

    $docroot = "/mnt/${server_ip}/wso2appm-1.0.0"

    class {'gateway':

        version            => '1.0.0',
        sub_cluster_domain => 'mgt',
        members            => {'gateway.wkr.wso2.com' => '4200'},
        local_member_host  => 'gateway.mgt.wso2.com',
        offset             => 0,
        hazelcast_port     => 4100,
        thrift_receive_port=> 10503,
        config_db          => 'AS_CONFIG_DB',
        config_target_path => 'AS_CONFIG_PATH',
        maintenance_mode   => 'zero',
        depsync            => false,
        clustering         => true,
        cloud              => false,
        owner              => 'root',
        group              => 'root',
        target             => "/mnt/${server_ip}"
    }
  
    require java  

    Class['java'] -> Class['gateway']
}

# gateway worker node
node /gateway.wkr.wso2.com/ inherits base {

    notify { $name: 
        message => "on gateway.wkr.wso2.com node",
    }

    $docroot = "/mnt/${server_ip}/wso2appm-1.0.0"

    class {'gateway':

        version            => '1.0.0',
        sub_cluster_domain => 'worker',
        members            => {'gateway.mgt.wso2.com' => '4100'},
        local_member_host  => 'gateway.wkr.wso2.com',
        offset             => 0,
        hazelcast_port     => 4200,
        thrift_receive_port=> 10504,
        config_db          => 'AS_CONFIG_DB',
        config_target_path => 'AS_CONFIG_PATH',
        maintenance_mode   => 'zero',
        depsync            => false,
        clustering         => true,
        cloud              => false,
        owner              => 'root',
        group              => 'root',
        target             => "/mnt/${server_ip}"
    }
  
    require java  

    Class['java'] -> Class['gateway']
}
