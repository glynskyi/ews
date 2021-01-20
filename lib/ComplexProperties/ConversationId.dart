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

import 'package:ews/ComplexProperties/ServiceId.dart';
import 'package:ews/Core/XmlElementNames.dart';

/// <summary>
/// Represents the Id of a Conversation.
/// </summary>
class ConversationId extends ServiceId {
  /// <summary>
  /// Initializes a new instance of the <see cref="ConversationId"/> class.
  /// </summary>
  ConversationId() : super() {}

  /// <summary>
  /// Defines an implicit conversion between String and ConversationId.
  /// </summary>
  /// <param name="uniqueId">The unique Id to convert to ConversationId.</param>
  /// <returns>A ConversationId initialized with the specified unique Id.</returns>
// static implicit operator ConversationId(String uniqueId)
//        {
//            return new ConversationId(uniqueId);
//        }

  /// <summary>
  /// Defines an implicit conversion between ConversationId and String.
  /// </summary>
  /// <param name="conversationId">The conversationId to String.</param>
  /// <returns>A ConversationId initialized with the specified unique Id.</returns>
// static implicit operator String(ConversationId conversationId)
//        {
//            if (conversationId == null)
//            {
//                throw new ArgumentNullException("conversationId");
//            }
//
//            if (StringUtils.IsNullOrEmpty(conversationId.UniqueId))
//            {
//                return String.Empty;
//            }
//            else
//            {
//                // Ignoring the change key info
//                return conversationId.UniqueId;
//            }
//        }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetXmlElementName() {
    return XmlElementNames.ConversationId;
  }

  /// <summary>
  /// Initializes a new instance of ConversationId.
  /// </summary>
  /// <param name="uniqueId">The unique Id used to initialize the <see cref="ConversationId"/>.</param>
  ConversationId.fromUniqueId(String uniqueId) : super.fromUniqueId(uniqueId) {}

  /// <summary>
  /// Gets a String representation of the Conversation Id.
  /// </summary>
  /// <returns>The String representation of the conversation id.</returns>
  @override
  String toString() {
    // We have ignored the change key portion
    return this.UniqueId!;
  }
}
