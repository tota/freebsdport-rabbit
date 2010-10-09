# New ports collection makefile for:	rabbit
# Date created:		2010-08-01
# Whom:			TAKATSU Tomonari <tota@FreeBSD.org>
#
# $FreeBSD: ports/misc/rabbit/Makefile,v 1.4 2010/08/07 11:49:37 tota Exp $
#

PORTNAME=	rabbit
PORTVERSION=	0.9.0
CATEGORIES=	misc ruby
MASTER_SITES=	http://www.cozmixng.org/~kou/download/ \
		${MASTER_SITE_LOCAL:S|%SUBDIR%|tota/rabbit|}

MAINTAINER=	tota@FreeBSD.org
COMMENT=	An RD-document-based presentation application

RUN_DEPENDS=	${RUBY_SITEARCHLIBDIR}/gtk2.so:${PORTSDIR}/x11-toolkits/ruby-gtk2 \
		${LOCALBASE}/bin/rd2:${PORTSDIR}/textproc/ruby-rdtool \
		rubygem-net-irc:${PORTSDIR}/irc/rubygem-net-irc

USE_RUBY=	yes
USE_RUBY_SETUP=	yes

RUBY_SHEBANG_FILES=	bin/rabbirc bin/rabbit bin/rabbit-command \
			bin/rabbit-theme-manager bin/rabbiter bin/rabrick

DOCS_EN=	NEWS.en README.en
DOCS_JA=	NEWS.ja README.ja

pre-install:
	${RM} -f ${WRKSRC}/bin/rabbit.bat

post-install:
.if !defined(NOPORTDOCS)
	${MKDIR} ${DOCSDIR}/ja
.for f in ${DOCS_EN}
	${INSTALL_DATA} ${WRKSRC}/${f} ${DOCSDIR}
.endfor
.for f in ${DOCS_JA}
	${INSTALL_DATA} ${WRKSRC}/${f} ${DOCSDIR}/ja
.endfor
.endif
.if !defined(NOPORTEXAMPLES)
	${MKDIR} ${EXAMPLESDIR}
	cd ${WRKSRC}/sample && ${COPYTREE_SHARE} . ${EXAMPLESDIR}
.endif

x-generate-plist:
	${CP} /dev/null pkg-plist.new
.for f in ${RUBY_SHEBANG_FILES}
	${ECHO} ${f} >> pkg-plist.new
.endfor
	${FIND} ${RUBY_SITELIBDIR}/rabbit -type f | ${SORT} | ${SED} -e 's,${RUBY_SITELIBDIR},%%RUBY_SITELIBDIR%%,' >> pkg-plist.new
	${FIND} ${RUBY_SITELIBDIR}/rwiki -type f | ${SORT} | ${SED} -e 's,${RUBY_SITELIBDIR},%%RUBY_SITELIBDIR%%,' >> pkg-plist.new
	${FIND} ${DATADIR} -type f | ${SORT} | ${SED} -e 's,${DATADIR},%%DATADIR%%,' >> pkg-plist.new
	${FIND} ${PREFIX}/share/locale -type f -name rabbit.mo | ${SORT} | ${SED} -e 's,^${PREFIX}/,,' >> pkg-plist.new
	${FIND} ${DOCSDIR} -type f | ${SORT} | ${SED} -e 's,${DOCSDIR},%%PORTDOCS%%%%DOCSDIR%%,' >> pkg-plist.new
	${FIND} ${EXAMPLESDIR} -type f | ${SORT} | ${SED} -e 's,${EXAMPLESDIR},%%PORTDOCS%%%%EXAMPLESDIR%%,' >> pkg-plist.new
	${FIND} ${EXAMPLESDIR} -type d -depth | ${SORT} -r | ${SED} -e 's,${EXAMPLESDIR},%%PORTDOCS%%@dirrm %%EXAMPLESDIR%%,' >> pkg-plist.new
	${FIND} ${DOCSDIR} -type d -depth | ${SORT} -r | ${SED} -e 's,${DOCSDIR},%%PORTDOCS%%@dirrm %%DOCSDIR%%,' >> pkg-plist.new
	${FIND} ${DATADIR} -type d -depth | ${SORT} -r | ${SED} -e 's,${DATADIR},@dirrm %%DATADIR%%,' >> pkg-plist.new
	${FIND} ${RUBY_SITELIBDIR}/rwiki -type d -depth | ${SORT} -r | ${SED} -e 's,${RUBY_SITELIBDIR},@dirrm %%RUBY_SITELIBDIR%%,' >> pkg-plist.new
	${FIND} ${RUBY_SITELIBDIR}/rabbit -type d -depth | ${SORT} -r | ${SED} -e 's,${RUBY_SITELIBDIR},@dirrm %%RUBY_SITELIBDIR%%,' >> pkg-plist.new

.include <bsd.port.mk>
