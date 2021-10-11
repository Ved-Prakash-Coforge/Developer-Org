#!groovy
import groovy.json.JsonSlurperClassic
node {

    def BUILD_NUMBER=env.BUILD_NUMBER
    def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
    def SFDC_USERNAME

    def HUB_ORG=env.HUB_ORG_DH
    def SFDC_HOST = env.SFDC_HOST_DH
    def JWT_KEY_CRED_ID = env.JWT_CRED_ID_DH
    def CONNECTED_APP_CONSUMER_KEY=env.CONNECTED_APP_CONSUMER_KEY_DH

    println 'KEY IS' 
    println JWT_KEY_CRED_ID
    println HUB_ORG
    println SFDC_HOST
    println CONNECTED_APP_CONSUMER_KEY
    def toolbelt = 'C:/"Program Files"/sfdx/bin/sfdx'         //tool 'toolbelt'

    stage('checkout source') {
        // when running in multi-branch job, one must issue this command
        checkout scm
    }
	println 'Step 1'
    withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')]) {
        stage('Deploye Code') {
            if (isUnix()) {
                rc = sh returnStatus: true, script: "${toolbelt} auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
            }else{
		    //bat "${toolbelt} plugins:install salesforcedx@49.5.0"
		    //bat "${toolbelt} update" --commented by Ved as right now update is not required
		    //bat "${toolbelt} auth:logout -u ${HUB_ORG} -p" 
                 rc = bat returnStatus: true, script: "${toolbelt} auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --loglevel DEBUG --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
            }
		
            if (rc != 0) { 
		    println 'inside rc 0'
		    error 'hub org authorization failed' 
	    }
		else{
			println 'rc not 0'
		}

			println rc
			
			//validate the build to deploy
			println 'validation inprogress......'
			if (isUnix()) {
				rmsg = bat returnStdout: true, script: "${toolbelt} force:source:deploy -x manifest/package.xml -l RunAllTestsInOrg -c -u ${HUB_ORG}"
			}else{
				rmsg = bat returnStdout: true, script: "${toolbelt} force:source:deploy -x manifest/package.xml -l RunAllTestsInOrg -c -u ${HUB_ORG}"
			}
		
	    println('-------------Temp-------------------')
	    printf rmsg
            println('Hello from a Job DSL script!')
            println(rmsg)
		
		def deploymentId = ''
		if(rmsg.contains('Successfully validated the deployment')){
			String[] resultArray = rmsg.split('Deploy ID:');
			println(resultArray)
			if(resultArray.size() > 0){
				resultArray = resultArray[1].split('Successfully validated the deployment');
				println(resultArray)
				if(resultArray.size() > 0){
					deploymentId = resultArray[0];
				}
			}
			println(deploymentId)
			// need to pull out assigned username
			if (isUnix()) {
				//rmsg = sh returnStdout: true, script: "${toolbelt} force:mdapi:deploy -d manifest/. -u ${HUB_ORG}"
				//rmsg = sh returnStdout: true, script: "${toolbelt} force:source:deploy -x manifest/package.xml -u ${HUB_ORG}"
				rmsg = sh returnStdout: true, script: "${toolbelt} force:source:deploy -q ${deploymentId} -u ${HUB_ORG}"
			}else{
				//rmsg = bat returnStdout: true, script: "${toolbelt} force:source:deploy -x manifest/package.xml -u ${HUB_ORG}"
			   	//rmsg = bat returnStdout: true, script: "${toolbelt} force:mdapi:deploy -d manifest/. -u ${HUB_ORG}"
				rmsg = bat returnStdout: true, script: "${toolbelt} force:source:deploy -q ${deploymentId} -u vprakash28jan89@gmail.com.new"
			}
		}
		println('Source deployed in org')
		println(rmsg)
        }
    }
}
