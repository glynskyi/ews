/*
 * Exchange Web Services Managed API
 *
 * Copyright (c) Microsoft Corporation
 * All rights reserved.
 *
 * MIT License
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this
 * software and associated documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
 * to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
 * FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

import 'package:ews/Http/ICredentials.dart';
import 'package:ews/Interfaces/IEwsHttpWebRequest.dart';
import 'package:ews/Xml/XmlWriter.dart';
import 'package:ews/misc/Std/MemoryStream.dart';

/// <summary>
/// Base class of Exchange credential types.
/// </summary>
abstract class ExchangeCredentials implements ICredentials {
  static final String WsSecurityPathSuffix = "/wssecurity";

  /// <summary>
  /// Performs an implicit conversion from <see cref="System.Net.NetworkCredential"/> to <see cref="Microsoft.Exchange.WebServices.Data.ExchangeCredentials"/>.
  /// This allows a NetworkCredential object to be implictly converted to an ExchangeCredential which is useful when setting
  /// credentials on an ExchangeService.
  /// </summary>
  /// <example>
  /// This operator allows you to type:
  /// <code>service.Credentials = new NetworkCredential("username","password");</code>
  /// instead of:
  /// <code>service.Credentials = new WebCredentials(new NetworkCredential("username","password"));</code>
  /// </example>
  /// <param name="credentials">The credentials.</param>
  /// <returns>The result of the conversion.</returns>
// static implicit operator ExchangeCredentials(NetworkCredential credentials)
//        {
//            return new WebCredentials(credentials);
//        }

  /// <summary>
  /// Performs an implicit conversion from <see cref="System.Net.CredentialCache"/> to <see cref="Microsoft.Exchange.WebServices.Data.ExchangeCredentials"/>.
  /// This allows a CredentialCache object to be implictly converted to an ExchangeCredential which is useful when setting
  /// credentials on an ExchangeService.
  /// </summary>
  /// <example>

  /// <code>CredentialCache credentials = new CredentialCache();</code>
  /// <code>credentials.Add(new Uri("http://www.contoso.com/"),"Basic",new NetworkCredential(user,pwd));</code>
  /// <code>credentials.Add(new Uri("http://www.contoso.com/"),"Digest", new NetworkCredential(user,pwd,domain));</code>
  /// This operator allows you to type:
  /// <code>service.Credentials = credentials;</code>
  /// instead of:
  /// <code>service.Credentials = new WebCredentials(credentials);</code>
  /// </example>
  /// <param name="credentials">The credentials.</param>
  /// <returns>The result of the conversion.</returns>
// static implicit operator ExchangeCredentials(CredentialCache credentials)
//        {
//            return new WebCredentials(credentials);
//        }

  /// <summary>
  /// Return the url without suffix.
  /// </summary>
  /// <param name="url">The url</param>
  /// <returns>The absolute uri base.</returns>
  static String GetUriWithoutSuffix(Uri url) {
    String absoluteUri = url.toString();

    int index = absoluteUri.indexOf(WsSecurityPathSuffix);
    if (index != -1) {
      return absoluteUri.substring(0, index);
    }

    return absoluteUri;
  }

  /// <summary>
  /// This method is called to pre-authenticate credentials before a service request is made.
  /// </summary>
  void PreAuthenticate() {
    // do nothing by default.
  }

  /// <summary>
  /// This method is called to apply credentials to a service request before the request is made.
  /// </summary>
  /// <param name="request">The request.</param>
  void PrepareWebRequest(IEwsHttpWebRequest request) {
    // do nothing by default.
  }

  /// <summary>
  /// Emit any extra necessary namespace aliases for the SOAP:header block.
  /// </summary>
  /// <param name="writer">The writer.</param>
  void EmitExtraSoapHeaderNamespaceAliases(XmlWriter? writer) {
    // do nothing by default.
  }

  /// <summary>
  /// Serialize any extra necessary SOAP headers.
  /// This is used for authentication schemes that rely on WS-Security, or for endpoints requiring WS-Addressing.
  /// </summary>
  /// <param name="writer">The writer.</param>
  /// <param name="webMethodName">The Web method being called.</param>
  void SerializeExtraSoapHeaders(XmlWriter? writer, String webMethodName) {
    // do nothing by default.
  }

  /// <summary>
  /// Serialize SOAP headers used for authentication schemes that rely on WS-Security
  /// </summary>
  /// <param name="writer">The writer.</param>
  void SerializeWSSecurityHeaders(XmlWriter? writer) {
    // do nothing by default.
  }

  /// <summary>
  /// Adjusts the URL endpoint based on the credentials.
  /// </summary>
  /// <param name="url">The URL.</param>
  /// <returns>Adjust URL.</returns>
  Uri AdjustUrl(Uri url) {
    return Uri.parse(GetUriWithoutSuffix(url));
  }

  /// <summary>
  /// Gets the flag indicating whether any sign action need taken.
  /// </summary>
  bool get NeedSignature => false;

  void Sign(MemoryStream memoryStream) {}

  /// <summary>
  /// Add the signature element to the memory stream.
  /// </summary>
  /// <param name="memoryStream">The memory stream.</param>
//        void Sign(MemoryStream memoryStream)
//        {
//            throw new InvalidOperationException();
//        }
}
