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

import 'package:ews/Core/EwsServiceXmlReader.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ItemFlagStatus.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';

import 'ComplexProperty.dart';

/// <summary>
    /// Encapsulates information on the occurrence of a recurring appointment.
    /// </summary>
  class Flag extends ComplexProperty
    {
        /* private */ ItemFlagStatus flagStatus;
        /* private */ DateTime startDate;
        /* private */ DateTime dueDate;
        /* private */ DateTime completeDate;

        /// <summary>
        /// Initializes a new instance of the <see cref="Flag"/> class.
        /// </summary>
 Flag()
        {
        }

        /// <summary>
        /// Tries to read element from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns>True if element was read.</returns>
@override
        bool TryReadElementFromXml(EwsServiceXmlReader reader)
        {
            switch (reader.LocalName)
            {
                case XmlElementNames.FlagStatus:
                    this.flagStatus = reader.ReadElementValue<ItemFlagStatus>();
                    return true;
                case XmlElementNames.StartDate:
                    this.startDate = reader.ReadElementValueAsDateTime();
                    return true;
                case XmlElementNames.DueDate:
                    this.dueDate = reader.ReadElementValueAsDateTime();
                    return true;
                case XmlElementNames.CompleteDate:
                    this.completeDate = reader.ReadElementValueAsDateTime();
                    return true;
                default:
                    return false;
            }
        }

        /// <summary>
        /// Writes elements to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.FlagStatus, this.FlagStatus);

            if (this.FlagStatus == ItemFlagStatus.Flagged)
            {
                writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.StartDate, this.StartDate);
                writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.DueDate, this.DueDate);
            }
            else if (this.FlagStatus == ItemFlagStatus.Complete)
            {
                writer.WriteElementValueWithNamespace(XmlNamespace.Types, XmlElementNames.CompleteDate, this.CompleteDate);
            }
        }

        /// <summary>
        /// Validates this instance.
        /// </summary>
        void Validate()
        {
            EwsUtilities.ValidateParam(this.flagStatus, "FlagStatus");
        }

        /// <summary>
        /// Gets or sets the flag status.
        /// </summary>
 ItemFlagStatus get FlagStatus => this.flagStatus;
 set FlagStatus(ItemFlagStatus value)
            {
              if (this.CanSetFieldValue(this.flagStatus, value)) {
                this.flagStatus = value;
                this.Changed();
              }
            }

        /// <summary>
        /// Gets the start date.
        /// </summary>
 DateTime get StartDate => this.startDate;
 set StartDate(DateTime value) {
   if (this.CanSetFieldValue(this.startDate, value)) {
     this.startDate = value;
     this.Changed();
   }
 }


        /// <summary>
        /// Gets the due date.
        /// </summary>
 DateTime get DueDate => this.dueDate;
 set DueDate(DateTime value) {
   if (this.CanSetFieldValue(this.dueDate, value)) {
     this.dueDate = value;
     this.Changed();
   }
 }

        /// <summary>
        /// Gets the complete date.
        /// </summary>
 DateTime get CompleteDate => this.completeDate;
  set CompleteDate(DateTime value) {
    if (this.CanSetFieldValue(this.completeDate, value)) {
      this.completeDate = value;
      this.Changed();
    }
  }

    }
