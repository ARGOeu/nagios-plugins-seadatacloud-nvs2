Name:		nagios-plugins-seadatacloud-nvs2
Version:	1.1.1
Release:	2%{?dist}
Summary:	Nagios nvs2 vocabulary probes
License:	GPLv3+
Packager:	Themis Zamani <themiszamani@gmail.com>

Source:		%{name}-%{version}.tar.gz
BuildArch:	noarch
BuildRoot:	%{_tmppath}/%{name}-%{version}
Requires(pre):  xmlstarlet
AutoReqProv: no

%description
Nagios probes to check functionality of the nvs2 vocabulary

%prep
%setup -q

%define _unpackaged_files_terminate_build 0 

%install

install -d %{buildroot}/%{_libexecdir}/argo-monitoring/probes/seadatacloud-nvs2
install -d %{buildroot}/%{_sysconfdir}/nagios/plugins/seadatacloud-nvs2
install -m 755 seadatacloud-nvs2.sh %{buildroot}/%{_libexecdir}/argo-monitoring/probes/seadatacloud-nvs2/seadatacloud-nvs2.sh

%files
%dir /%{_libexecdir}/argo-monitoring
%dir /%{_libexecdir}/argo-monitoring/probes/
%dir /%{_libexecdir}/argo-monitoring/probes/seadatacloud-nvs2

%attr(0755,root,root) /%{_libexecdir}/argo-monitoring/probes/seadatacloud-nvs2/seadatacloud-nvs2.sh

%changelog
Name:		nagios-plugins-seadatacloud-nvs2
Version:	1.1.1
Release:	2%{?dist}
Summary:	Nagios nvs2 vocabulary probes
License:	GPLv3+
Packager:	Themis Zamani <themiszamani@gmail.com>

Source:		%{name}-%{version}.tar.gz
BuildArch:	noarch
BuildRoot:	%{_tmppath}/%{name}-%{version}
Requires(pre):  xmlstarlet
AutoReqProv: no

%description
Nagios probes to check functionality of the nvs2 vocabulary

%prep
%setup -q

%define _unpackaged_files_terminate_build 0 

%install

install -d %{buildroot}/%{_libexecdir}/argo-monitoring/probes/seadatacloud-nvs2
install -d %{buildroot}/%{_sysconfdir}/nagios/plugins/seadatacloud-nvs2
install -m 755 seadatacloud-nvs2.sh %{buildroot}/%{_libexecdir}/argo-monitoring/probes/seadatacloud-nvs2/seadatacloud-nvs2.sh

%files
%dir /%{_libexecdir}/argo-monitoring
%dir /%{_libexecdir}/argo-monitoring/probes/
%dir /%{_libexecdir}/argo-monitoring/probes/seadatacloud-nvs2

%attr(0755,root,root) /%{_libexecdir}/argo-monitoring/probes/seadatacloud-nvs2/seadatacloud-nvs2.sh

%changelog
* Mon Oct 18 2021 Themis Zamani <themiszamani@gmail.com>  - 1.1.1-1%{?dist}
- Update curl options to stop receiving HTTPS 405 error.
* Wed Dec 09 2020 Themis Zamani <themiszamani@gmail.com>  - 1.1.0-1%{?dist}
- update it based on the new version of nvs
* Thu Apr 11 2019 Themis Zamani <themiszamani@gmail.com>  - 1.0.0-1%{?dist}
- Initial version of the package. Work done by Micahlis Iordanis - iordanism@hcmr.gr 

* Wed Dec 09 2020 Themis Zamani <themiszamani@gmail.com>  - 1.1.0-1%{?dist}
- update it based on the new version of nvs
* Thu Apr 11 2019 Themis Zamani <themiszamani@gmail.com>  - 1.0.0-1%{?dist}
- Initial version of the package. Work done by Micahlis Iordanis - iordanism@hcmr.gr 
