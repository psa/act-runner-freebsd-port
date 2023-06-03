# $FreeBSD$

PORTNAME=	act-runner
DISTVERSIONPREFIX=      v
DISTVERSION=	0.1.8
CATEGORIES=	devel

MAINTAINER=	freebsd-ports@otoh.org
COMMENT=	A runner for Gitea

DISTNAME=$(DISTVERSIONPREFIX)$(DISTVERSION)
MASTER_SITES=https://gitea.com/gitea/act_runner/archive/

LICENSE=	MIT

EXTRACT_DEPENDS=  ${RUN_DEPENDS} \
	bash:shells/bash \
	git:devel/git \
	gmake:devel/gmake 
	#npm:www/npm-node18

BUILD_DEPENDS= ${EXTRACT_DEPENDS} 

USES= gmake go:no_targets

USE_RC_SUBR=         act-runner
ACT_RUNNER_DATA_DIR= /var/db/act-runner
ACT_RUNNER_ETC_DIR=  /usr/local/etc/act-runner
SUB_LIST+=           ACT_RUNNER_DATA_DIR=${ACT_RUNNER_DATA_DIR}
SUB_FILES+=          pkg-install
BUILD_WRKSRC=        $(WRKDIR)/act_runner
SSP_UNSAFE=          true

pre-install:
	${MKDIR} ${STAGEDIR}${ACT_RUNNER_DATA_DIR} ${STAGEDIR}${ACT_RUNNER_ETC_DIR}

do-install:
	${INSTALL_SCRIPT} ${BUILD_WRKSRC}/act_runner ${STAGEDIR}${PREFIX}/sbin/act-runner
	${INSTALL_SCRIPT} ${BUILD_WRKSRC}/internal/pkg/config/config.example.yaml ${STAGEDIR}${ACT_RUNNER_ETC_DIR}/act-runner.conf.sample

.include <bsd.port.mk>
