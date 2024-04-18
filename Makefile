# $FreeBSD$

PORTNAME=		act-runner
DISTVERSIONPREFIX=	v
DISTVERSION=		0.2.10
CATEGORIES=		devel

MAINTAINER=	freebsd-ports@otoh.org
COMMENT=	A runner for Gitea

DISTNAME=	$(DISTVERSIONPREFIX)$(DISTVERSION)
MASTER_SITES+=	https://gitea.com/gitea/act_runner/archive/
WWW=		https://gitea.com/gitea/act_runner/

LICENSE=	MIT

EXTRACT_DEPENDS=	${RUN_DEPENDS} \
			bash:shells/bash \
			git:devel/git \
			gmake:devel/gmake

BUILD_DEPENDS=		${EXTRACT_DEPENDS}

USES=			gmake go:no_targets

# I haven't found the magic incantation to get GO_MODULES to play nice with
# Gitea. As such, this doesn't work with poudriere right now as it doesn't
# pre-fetch the dependencies.

USE_RC_SUBR=		act-runner
ACT_RUNNER_DATA_DIR=	/var/db/act-runner
ACT_RUNNER_ETC_DIR=	/usr/local/etc/act-runner
SUB_LIST+=		ACT_RUNNER_DATA_DIR=${ACT_RUNNER_DATA_DIR}
SUB_FILES+=		pkg-install
WRKSRC=			$(WRKDIR)/act_runner
# Required, otherwise: flag provided but not defined: -fstack-protector-strong
SSP_UNSAFE=		true

pre-install:
	${MKDIR} ${STAGEDIR}${ACT_RUNNER_DATA_DIR} \
		${STAGEDIR}${ACT_RUNNER_ETC_DIR}

do-install:
	${INSTALL_SCRIPT} ${WRKSRC}/act_runner \
		${STAGEDIR}${PREFIX}/sbin/act-runner
	${INSTALL_SCRIPT} ${WRKSRC}/internal/pkg/config/config.example.yaml \
		${STAGEDIR}${ACT_RUNNER_ETC_DIR}/act-runner.conf.sample

.include <bsd.port.mk>
