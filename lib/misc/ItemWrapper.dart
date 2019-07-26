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


import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/misc/AbstractItemIdWrapper.dart';

/// <summary>
    /// Represents an item Id provided by a ItemBase object.
    /// </summary>
    class ItemWrapper extends AbstractItemIdWrapper
    {
        /// <summary>
        /// The ItemBase object providing the Id.
        /// </summary>
        /* private */ Item item;

        /// <summary>
        /// Initializes a new instance of ItemWrapper.
        /// </summary>
        /// <param name="item">The ItemBase object provinding the Id.</param>
        ItemWrapper(Item item)
        {
            EwsUtilities.Assert(
                item != null,
                "ItemWrapper.ctor",
                "item is null");
            EwsUtilities.Assert(
                !item.IsNew,
                "ItemWrapper.ctor",
                "item does not have an Id");

            this.item = item;
        }

        /// <summary>
        /// Obtains the ItemBase object associated with the wrapper.
        /// </summary>
        /// <returns>The ItemBase object associated with the wrapper.</returns>
@override
 Item GetItem()
        {
            return this.item;
        }

        /// <summary>
        /// Writes the Id encapsulated in the wrapper to XML.
        /// </summary>
        /// <param name="writer">The writer to write the Id to.</param>
@override
        void WriteToXml(EwsServiceXmlWriter writer)
        {
            this.item.Id.WriteToXmlElemenetName(writer);
        }
    }
