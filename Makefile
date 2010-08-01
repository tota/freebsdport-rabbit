# New ports collection makefile for:	rabbit
# Date created:		2010-08-01
# Whom:			TAKATSU Tomonari <tota@FreeBSD.org>
#
# $FreeBSD$
#

PORTNAME=	rabbit
PORTVERSION=	0.6.4
CATEGORIES=	misc ruby
MASTER_SITES=	http://www.cozmixng.org/~kou/download/ \
		${MASTER_SITE_LOCAL:S|%SUBDIR%|tota/rabbit|}

MAINTAINER=	tota@FreeBSD.org
COMMENT=	An RD-document-based presentation application

RUN_DEPENDS=	${RUBY_SITEARCHLIBDIR}/gtk2.so:${PORTSDIR}/x11-toolkits/ruby-gtk2 \
		${LOCALBASE}/bin/rd2:${PORTSDIR}/textproc/ruby-rdtool

LICENSE=	GPLv2
LICENSE_FILE=	${WRKSRC}/COPYING

USE_RUBY=	yes
USE_RUBY_SETUP=	yes

DOCS_EN=	NEWS.en README.en
DOCS_JA=	NEWS.ja README.ja

post-install:
.if !defined(NOPORTEXAMPLES)
	${MKDIR} ${EXAMPLESDIR}
	${CP} -pR ${WRKSRC}/sample/* ${EXAMPLESDIR}
	${CHOWN} -R ${SHAREOWN}:${SHAREGRP} ${EXAMPLESDIR}
.endif
.if !defined(NOPORTDOCS)
	${MKDIR} ${DOCSDIR}/ja
.for f in ${DOCS_EN}
	${INSTALL_DATA} ${WRKSRC}/${f} ${DOCSDIR}
.endfor
.for f in ${DOCS_JA}
	${INSTALL_DATA} ${WRKSRC}/${f} ${DOCSDIR}/ja
.endfor
.endif

x-generate-plist:
	${ECHO} bin/rabbirc > pkg-plist.new
	${ECHO} bin/rabbit >> pkg-plist.new
	${ECHO} bin/rabbit-command >> pkg-plist.new
	${ECHO} bin/rabbit-theme-manager >> pkg-plist.new
	${ECHO} bin/rabbit.bat >> pkg-plist.new
	${ECHO} bin/rabrick >> pkg-plist.new
	${FIND} ${RUBY_SITELIBDIR}/rabbit -type f | ${SORT} | ${SED} -e 's,${RUBY_SITELIBDIR},%%RUBY_SITELIBDIR%%,' >> pkg-plist.new
	${FIND} ${RUBY_SITELIBDIR}/rwiki -type f | ${SORT} | ${SED} -e 's,${RUBY_SITELIBDIR},%%RUBY_SITELIBDIR%%,' >> pkg-plist.new
	${FIND} ${DATADIR} -type f | ${SORT} | ${SED} -e 's,${DATADIR},%%DATADIR%%,' >> pkg-plist.new
	${FIND} ${PREFIX}/share/locale -type f -name rabbit.mo | ${SORT} | ${SED} -e 's,^${PREFIX}/,,' >> pkg-plist.new
	${FIND} ${WRKSRC}/sample -type f | ${SORT} | ${SED} -e 's,${WRKSRC}/sample,%%PORTDOCS%%%%EXAMPLESDIR%%,' >> pkg-plist.new
	${ECHO} %%PORTDOCS%%%%DOCSDIR%%/NEWS.en >> pkg-plist.new
	${ECHO} %%PORTDOCS%%%%DOCSDIR%%/README.en >> pkg-plist.new
	${ECHO} %%PORTDOCS%%%%DOCSDIR%%/ja/NEWS.ja >> pkg-plist.new
	${ECHO} %%PORTDOCS%%%%DOCSDIR%%/ja/README.ja >> pkg-plist.new
	${ECHO} %%PORTDOCS%%@dirrm %%DOCSDIR%%/ja >> pkg-plist.new
	${ECHO} %%PORTDOCS%%@dirrm %%DOCSDIR%% >> pkg-plist.new
	${FIND} ${WRKSRC}/sample -type d -depth | ${SORT} -r | ${SED} -e 's,${WRKSRC}/sample,%%PORTDOCS%%@dirrm %%EXAMPLESDIR%%,' >> pkg-plist.new
	${ECHO} @dirrmtry share/locale/ja/LC_MESSAGES >> pkg-plist.new
	${ECHO} @dirrmtry share/locale/ja >> pkg-plist.new
	${ECHO} @dirrmtry share/locale/fr/LC_MESSAGES >> pkg-plist.new
	${ECHO} @dirrmtry share/locale/fr >> pkg-plist.new
	${ECHO} @dirrmtry share/locale/en/LC_MESSAGES >> pkg-plist.new
	${ECHO} @dirrmtry share/locale/en >> pkg-plist.new
	${FIND} ${DATADIR} -type d -depth | ${SORT} -r | ${SED} -e 's,${DATADIR},@dirrm %%DATADIR%%,' >> pkg-plist.new
	${FIND} ${RUBY_SITELIBDIR}/rwiki -type d -depth | ${SORT} -r | ${SED} -e 's,${RUBY_SITELIBDIR},@dirrm %%RUBY_SITELIBDIR%%,' >> pkg-plist.new
	${FIND} ${RUBY_SITELIBDIR}/rabbit -type d -depth | ${SORT} -r | ${SED} -e 's,${RUBY_SITELIBDIR},@dirrm %%RUBY_SITELIBDIR%%,' >> pkg-plist.new

.include <bsd.port.mk>
