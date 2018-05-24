FROM ansibleplaybookbundle/apb-base

RUN yum -y install epel-release \
 && yum -y install centos-release-openshift-origin \
 && yum -y install origin-clients java-openjdk \
 && yum clean all

LABEL "com.redhat.apb.spec"=\
"dmVyc2lvbjogMS4wCm5hbWU6IG9wZW5zaGlmdC1sb2dnaW5nLWFwYgpkZXNjcmlwdGlvbjogVGhp\
cyBBUEIgd2lsbCBkZXBsb3kgb3BlbnNoaWZ0LWxvZ2dpbmcuIFBsZWFzZSBzZWUgaHR0cHM6Ly9n\
aXRodWIuY29tL2Fuc2libGVwbGF5Ym9va2J1bmRsZXMvb3BlbnNoaWZ0LWxvZ2dpbmctYXBiIGJl\
Zm9yZSBhdHRlbXB0aW5nIHRvIHJ1biBpdCBhcyBpdCBoYXMgc3BlY2lhbCBwcmUtcmVxdWlzaXRl\
cy4KYmluZGFibGU6IEZhbHNlCmFzeW5jOiBvcHRpb25hbAptZXRhZGF0YToKICBkaXNwbGF5TmFt\
ZTogb3BlbnNoaWZ0LWxvZ2dpbmcKcGxhbnM6CiAgLSBuYW1lOiBkZWZhdWx0CiAgICBkZXNjcmlw\
dGlvbjogVGhpcyBkZWZhdWx0IHBsYW4gZGVwbG95cyBvcGVuc2hpZnQtbG9nZ2luZy1hcGIKICAg\
IGZyZWU6IFRydWUKICAgIG1ldGFkYXRhOiB7fQogICAgcGFyYW1ldGVyczoKICAgIC0gbmFtZTog\
cHVibGljX2hvc3RuYW1lCiAgICAgIGRlZmF1bHQ6IDEyNy4wLjAuMS5uaXAuaW8KICAgICAgdHlw\
ZTogc3RyaW5nCiAgICAgIHRpdGxlOiBPcGVuc2hpZnQgQ2x1c3RlciBQdWJsaWMgSG9zdG5hbWUK\
ICAgICAgcmVxdWlyZWQ6IFRydWUK"

RUN mkdir -p /etc/origin/master && chmod 777 -R /etc/origin
RUN git clone https://github.com/jmontleon/openshift-ansible -b openshift-logging-apb && mv openshift-ansible/roles /opt/ansible/ && rm -rf openshift-ansible
COPY roles/openshift-logging-apb-pre /opt/ansible/roles/openshift-logging-apb-pre
COPY roles/openshift-logging-apb-post opt/ansible/roles/openshift-logging-apb-post
COPY playbooks /opt/apb/actions
RUN chmod -R g=u /opt/{ansible,apb}
USER apb
