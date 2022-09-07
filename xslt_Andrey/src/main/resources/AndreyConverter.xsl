<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html"/>
    <xsl:template match="/">
        <html>
            <body>
                <h2>Пользователи</h2>
                <table border="1">
                    <tr bgcolor="#9370db">
                        <th>ID</th>
                        <th>Имя</th>
                        <th>Фамилия</th>
                        <th>Номер телефона</th>
                    </tr>
                    <xsl:for-each select="System/personList/person">
                        <xsl:sort select="System/personList/person/@id" order="descending"/>
                        <tr>
                            <xsl:call-template name="one"/>
                        </tr>
                    </xsl:for-each>
                    <tr>
                        <td>Всего пользователй</td>
                        <xsl:variable name="count" select="count(System/personList/person)"/>
                        <td>
                            <xsl:value-of select="$count"/>
                        </td>
                    </tr>
                </table>
                <xsl:for-each select="System/chatHistory/chat">
                    <xsl:if test="type/@name = 'private'">
                        <h2>
                            <xsl:text>Чат </xsl:text><xsl:value-of select="@id"/>
                            <xsl:text> | Тип чата:  </xsl:text><xsl:value-of select="type/@name"/>
                            <xsl:text> | Чат создан:  </xsl:text><xsl:value-of select="type/dateOfCreation"/>
                        </h2>
                    </xsl:if>
                    <xsl:if test="type/@name = 'group'">
                        <h2>
                            <xsl:text>Чат </xsl:text><xsl:value-of select="@id"/>
                            <xsl:text> | Тип чата:  </xsl:text><xsl:value-of select="type/@name"/>
                            <xsl:text> | Чат создан:  </xsl:text><xsl:value-of select="type/dateOfCreation"/>
                            <xsl:text> | Название чата:  </xsl:text><xsl:value-of select="type/title"/>
                        </h2>
                    </xsl:if>
                    <table border="1">
                        <tr bgcolor="#9370db">
                            <th>ID отправителя</th>
                            <th>ID получателя</th>
                            <th>Время сообщения</th>
                            <th>Тип сообщения</th>
                            <xsl:if test="messageList/message/content/@name = 'file'">
                                <th>Кодировка</th>
                                <th>Контент</th>
                            </xsl:if>
                            <xsl:if test="messageList/message/content/@name = 'text'">
                                <th>Контент</th>
                            </xsl:if>
                        </tr>
                        <xsl:for-each select="messageList/message">
                            <tr>
                                <td>
                                    <xsl:value-of select="sender/@idref"/>
                                </td>
                                <td>
                                    <xsl:value-of select="receivers/personRef/@idref"/>
                                </td>
                                <td>
                                    <xsl:value-of select="time"/>
                                </td>
                                <xsl:choose>
                                    <xsl:when test="content/@name = 'file'">
                                        <td>
                                            <xsl:value-of select="content/file/@type"/>
                                        </td>
                                        <xsl:if test="content/file/@messageEncoded = 0">
                                            <td bgcolor="#FA8072">Раскодировано</td>
                                        </xsl:if>
                                        <xsl:if test="content/file/@messageEncoded = 1">
                                            <td bgcolor="#a5e327">Закодировано</td>
                                        </xsl:if>
                                        <td>
                                            <xsl:value-of select="content/file"/>
                                        </td>
                                    </xsl:when>
                                    <xsl:when test="content/@name = 'text'">
                                        <td>
                                            <xsl:text>Текст</xsl:text>
                                        </td>
                                        <td>
                                            <xsl:value-of select="content/text"/>
                                        </td>
                                    </xsl:when>
                                </xsl:choose>
                            </tr>
                        </xsl:for-each>
                    </table>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
    <xsl:template name="one" match="System/personList/person">
        <td>
            <xsl:value-of select="generate-id()"/>
        </td>
        <td>
            <xsl:value-of select="firstName"/>
        </td>
        <td>
            <xsl:value-of select="lastName"/>
        </td>
        <td>
            <xsl:value-of select="89190149749"/>
        </td>
    </xsl:template>
</xsl:stylesheet>